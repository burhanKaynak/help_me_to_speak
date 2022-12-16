import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/available_conversation_type_enum.dart';
import '../../enum/translator_status_enum.dart';
import '../../models/response/customer_model.dart';
import '../../models/response/language_model.dart';
import '../../service/database_service.dart';
import '../../utils/utils.dart';

part 'translator_event.dart';
part 'translator_state.dart';

class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  List<AvailableConversationType> listAvailableConversationList = [];
  List<TranslatorStatus> listTranslatorStatus = [];
  List<Language> listLanguage = [];

  List<Customer> _translatorList = [];

  TranslatorBloc() : super(TranslatorInitial()) {
    on<GetTranslators>(_getTranslator);
    on<AddTranslatorForChat>(_addTranslatorForChat);
    on<SearchTranslators>(_searchTranslator);
  }

  _getTranslator(GetTranslators event, emit) async {
    _translatorList = await DatabaseService.instance.getTranslators();
    for (var item in _translatorList) {
      item.isAvailable = await _isAvailable(item.uid);
    }

    emit(TranslatorLoaded(_translatorList));
  }

  _addTranslatorForChat(AddTranslatorForChat event, emit) async {
    var result = await DatabaseService.instance
        .createConversation(event.currentUid, event.reciverUid);
    emit(TranslatorAdded(result));
  }

  _searchTranslator(SearchTranslators event, emit) {
    emit(TranslatorInitial());
    var searchDataList = List<Customer>.from(_translatorList);

    searchDataList = searchDataList.where((item) {
      String firstString = Utils().replaceSymbolAndTr(item.displayName!);
      String secondString = Utils().replaceSymbolAndTr(event.text);
      return firstString.contains(secondString);
    }).toList();
    searchDataList = _getAvailableConversation(searchDataList);
    searchDataList = _getAvailableLanguages(searchDataList);
    searchDataList = _getAvailableTranslator(searchDataList);

    emit(TranslatorLoaded(searchDataList));
  }

  List<Customer> _getAvailableConversation(List<Customer> customers) {
    if (listAvailableConversationList.isNotEmpty) {
      customers = customers.where((e) {
        var contains = <AvailableConversationType>[];

        if (e.availableChat!) {
          contains.add(AvailableConversationType.chat);
        }
        if (e.availableVideoCall!) {
          contains.add(AvailableConversationType.videoCall);
        }
        if (e.availableVoiceCall!) {
          contains.add(AvailableConversationType.voiceCall);
        }

        return contains
            .any((item) => listAvailableConversationList.contains(item));
      }).toList();
    }
    return customers;
  }

  List<Customer> _getAvailableLanguages(List<Customer> customers) {
    if (listLanguage.isEmpty) return customers;
    var filteredCustomers = <Customer>[];

    for (var item in customers) {
      var result = item.languagesOfTranslate!.any((element) {
        return listLanguage.any((item) => item.docId == element.id);
      });
      if (result) {
        filteredCustomers.add(item);
      }
    }

    return filteredCustomers;
  }

  List<Customer> _getAvailableTranslator(List<Customer> customers) {
    if (listTranslatorStatus.isEmpty) return customers;
    var filteredCustomers = <Customer>[];

    if (listTranslatorStatus.contains(TranslatorStatus.busy) &&
        listTranslatorStatus.contains(TranslatorStatus.online)) {
      filteredCustomers = customers;
    } else if (listTranslatorStatus.contains(TranslatorStatus.online)) {
      filteredCustomers = customers.where((e) => e.isAvailable!).toList();
    } else if (listTranslatorStatus.contains(TranslatorStatus.busy)) {
      filteredCustomers = customers.where((e) => !e.isAvailable!).toList();
    }

    return filteredCustomers;
  }

  Future<bool> _isAvailable(id) async {
    var day = DateTime.now().day;
    var month = DateTime.now().month;
    var year = DateTime.now().year;
    var rezervations = await DatabaseService.instance.getRezervation(id);

    var busyDate = rezervations.busyDate!
        .any((e) => e.day == day && e.month == month && e.year == year);

    var rezervationDate = rezervations.rezervationDate!
        .any((e) => e.day == day && e.month == month && e.year == year);

    return !rezervationDate && !busyDate;
  }
}
