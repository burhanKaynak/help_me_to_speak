part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class GetConversations extends ConversationEvent {}

class SearchConversations extends ConversationEvent {
  final String text;
  const SearchConversations(this.text);
}
