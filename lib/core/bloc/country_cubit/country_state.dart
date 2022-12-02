part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoaded extends CountryState {
  final List<Language> data;
  const CountryLoaded(this.data);
}

class CountryError extends CountryState {
  final String errorMessage;
  const CountryError(this.errorMessage);
}
