import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

import '../../models/response/rezervation_model.dart';

part 'rezervation_event.dart';
part 'rezervation_state.dart';

class RezervationBloc extends Bloc<RezervationEvent, RezervationState> {
  RezervationBloc() : super(RezervationInitial()) {
    on<GetRezervation>((event, emit) async {
      var result = await _getRezervation(event.translatorId);
      emit(RezervationLoaded(result));
    });
    on<SetRezervation>((event, emit) async {
      emit(RezervationInitial());
      var resultSetData = await DatabaseService.instance
          .setRezervation(event.translatorId, event.rezervationDates);

      if (!resultSetData) return;

      var result = await _getRezervation(event.translatorId);
      emit(RezervationLoaded(result));
    });
  }

  Future<Rezervation> _getRezervation(translatorId) async {
    return await DatabaseService.instance.getRezervation(translatorId);
  }
}
