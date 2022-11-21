part of 'translator_bloc.dart';

abstract class TranslatorEvent extends Equatable {
  const TranslatorEvent();
  @override
  List<Object> get props => [];
}

class GetTranslators extends TranslatorEvent {}

class AddTranslatorForChat extends TranslatorEvent {
  final String currentUid, reciverUid;
  const AddTranslatorForChat(
      {required this.currentUid, required this.reciverUid});
}
