import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

import '../../models/response/chat_model.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<GetConversations>((event, emit) async {
      var result = await DatabaseService.instance.getConversations();
      List<Chat> chats = [];
      for (var item in result) {
        for (var doc in item['members']) {
          var customers = await DatabaseService.instance.getCustomer(doc);
          var chatSnapshoot =
              DatabaseService.instance.getConversationSnapShoot(customers.uid);
          chats.add(
              Chat(customers, await chatSnapshoot, item['conversationId']));
        }
      }
      emit(ConversationLoaded(chats));
    });
  }
}
