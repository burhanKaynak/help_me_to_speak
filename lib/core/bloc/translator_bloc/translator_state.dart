part of 'translator_bloc.dart';

abstract class TranslatorState extends Equatable {
  const TranslatorState();
  @override
  List<Object> get props => [];
}

class TranslatorInitial extends TranslatorState {}

class TranslatorLoaded extends TranslatorState {
  final List<Customer> translators;
  const TranslatorLoaded(this.translators);
}

class TranslatorAdded extends TranslatorState {
  final bool state;
  const TranslatorAdded(this.state);
}

class TranslatorError extends TranslatorState {
  final String errorMessage;
  const TranslatorError(this.errorMessage);
}
