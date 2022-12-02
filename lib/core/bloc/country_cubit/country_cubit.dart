import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  Future<void> getLanguages() async {
    var result = await DatabaseService.instance.getLanguages();
    emit(CountryLoaded(result));
  }
}
