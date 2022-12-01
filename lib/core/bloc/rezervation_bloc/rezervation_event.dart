part of 'rezervation_bloc.dart';

abstract class RezervationEvent extends Equatable {
  const RezervationEvent();

  @override
  List<Object> get props => [];
}

class GetRezervation extends RezervationEvent {
  final String translatorId;
  const GetRezervation(this.translatorId);
}

class SetRezervation extends RezervationEvent {
  final String translatorId;
  final List<DateTime> rezervationDates;
  const SetRezervation(this.translatorId, this.rezervationDates);
}
