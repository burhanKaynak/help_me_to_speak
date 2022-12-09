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
  List<AvaibleConversationType> listAvaibleConversationList = [];
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
    emit(TranslatorLoaded(searchDataList));
  }
}
