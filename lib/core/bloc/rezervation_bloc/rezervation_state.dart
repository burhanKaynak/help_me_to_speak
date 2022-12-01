part of 'rezervation_bloc.dart';

abstract class RezervationState extends Equatable {
  const RezervationState();

  @override
  List<Object> get props => [];
}

class RezervationInitial extends RezervationState {}

class RezervationLoaded extends RezervationState {
  final Rezervation data;
  const RezervationLoaded(this.data);
}

class RezervationError extends RezervationState {
  final String errorMessage;
  const RezervationError(this.errorMessage);
}
