import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());
  late List<Language> _languages;

  ValueNotifier<List<Language>> list = ValueNotifier([]);
  ValueNotifier<List<Language>> selectedCountry = ValueNotifier([]);
  ValueNotifier<List<Language>> selectedNativeLanguage = ValueNotifier([]);
  ValueNotifier<List<Language>> selectedSupportLanguage = ValueNotifier([]);

  Future<void> getLanguages() async {
    _languages = await DatabaseService.instance.getLanguages();
    if (AuthService.instance.getCustomer != null &&
        AuthService.instance.getCustomer?.country != null) {
      selectedCountry.value = await DatabaseService.instance
          .getLanguagesFromRef([AuthService.instance.getCustomer!.country!]);

      selectedNativeLanguage.value = await DatabaseService.instance
          .getLanguagesFromRef(
              AuthService.instance.getCustomer!.nativeLanguages!);

      selectedSupportLanguage.value = await DatabaseService.instance
          .getLanguagesFromRef(
              AuthService.instance.getCustomer!.supportLanguages!);
    }

    list.value = _languages;
    emit(CountryLoaded(list.value));
  }

  Future<bool> setCountryAndLanguages() async {
    var result = await DatabaseService.instance.setCountryAndLanguages(
        country: selectedCountry.value.first,
        languages: selectedNativeLanguage.value,
        supportLanguages: selectedSupportLanguage.value);
    return result;
  }

  Future<void> searchList(String key) async {
    var searchData = _languages
        .where((e) => e.language!.toLowerCase().contains(key.toLowerCase()))
        .toList();
    list.value = searchData;
  }
}
