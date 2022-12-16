import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enum/available_conversation_type_enum.dart';
import '../../enum/translator_status_enum.dart';
import '../../models/response/chat_model.dart';
import '../../models/response/language_model.dart';
import '../../service/database_service.dart';
import '../../utils/utils.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  List<AvailableConversationType> listAvaibleConversationList = [];
  List<TranslatorStatus> listTranslatorStatus = [];
  List<Language> listLanguage = [];

  List<Chat> _conversationList = [];

  ConversationBloc() : super(ConversationInitial()) {
    on<GetConversations>(_getConversations);
    on(_searchTranslator);
  }

  _getConversations(GetConversations event, emit) async {
    var result = await DatabaseService.instance.getConversations();
    for (var item in result) {
      for (var doc in item['members']) {
        var customers = await DatabaseService.instance.getCustomer(doc);
        customers.isAvailable = await _isAvailable(customers.uid);

        var chatSnapshoot =
            DatabaseService.instance.getConversationSnapShoot(customers.uid);
        _conversationList
            .add(Chat(customers, await chatSnapshoot, item['conversationId']));
      }
    }

    emit(ConversationLoaded(_conversationList));
  }

  _searchTranslator(SearchConversations event, emit) {
    emit(ConversationInitial());
    var searchDataList = List<Chat>.from(_conversationList);

    searchDataList = searchDataList.where((item) {
      String firstString =
          Utils().replaceSymbolAndTr(item.customer.displayName!);
      String secondString = Utils().replaceSymbolAndTr(event.text);
      return firstString.contains(secondString);
    }).toList();

    searchDataList = _getAvailableConversation(searchDataList);
    searchDataList = _getAvailableLanguages(searchDataList);
    searchDataList = _getAvailableTranslator(searchDataList);

    emit(ConversationLoaded(searchDataList));
  }

  List<Chat> _getAvailableConversation(List<Chat> chats) {
    if (listAvaibleConversationList.isNotEmpty) {
      chats = chats.where((e) {
        var contains = <AvailableConversationType>[];

        if (e.customer.availableChat!) {
          contains.add(AvailableConversationType.chat);
        }
        if (e.customer.availableVideoCall!) {
          contains.add(AvailableConversationType.videoCall);
        }
        if (e.customer.availableVoiceCall!) {
          contains.add(AvailableConversationType.voiceCall);
        }

        return contains
            .any((item) => listAvaibleConversationList.contains(item));
      }).toList();
    }
    return chats;
  }

  List<Chat> _getAvailableLanguages(List<Chat> chats) {
    if (listLanguage.isEmpty) return chats;
    var filteredCustomers = <Chat>[];

    for (var item in chats) {
      var result = item.customer.languagesOfTranslate!.any((element) {
        return listLanguage.any((item) => item.docId == element.id);
      });
      if (result) {
        filteredCustomers.add(item);
      }
    }

    return filteredCustomers;
  }

  List<Chat> _getAvailableTranslator(List<Chat> chats) {
    if (listTranslatorStatus.isEmpty) return chats;
    var filteredChats = <Chat>[];

    if (listTranslatorStatus.contains(TranslatorStatus.busy) &&
        listTranslatorStatus.contains(TranslatorStatus.online)) {
      filteredChats = chats;
    } else if (listTranslatorStatus.contains(TranslatorStatus.online)) {
      filteredChats = chats.where((e) => e.customer.isAvailable!).toList();
    } else if (listTranslatorStatus.contains(TranslatorStatus.busy)) {}

    return filteredChats;
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
