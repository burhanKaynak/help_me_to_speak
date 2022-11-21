part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<Chat> chats;
  const ConversationLoaded(this.chats);
}

class ConversationError extends ConversationState {
  final String errorMessage;
  const ConversationError(this.errorMessage);
}
