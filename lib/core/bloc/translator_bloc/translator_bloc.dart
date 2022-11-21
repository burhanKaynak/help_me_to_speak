import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_me_to_speak/core/models/response/customer_model.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

part 'translator_event.dart';
part 'translator_state.dart';

class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  TranslatorBloc() : super(TranslatorInitial()) {
    on<GetTranslators>((event, emit) async {
      var customers = await DatabaseService.instance.getTranslators();
      emit(TranslatorLoaded(customers));
    });
    on<AddTranslatorForChat>((event, emit) async {
      var result = await DatabaseService.instance
          .createConversation(event.currentUid, event.reciverUid);
      emit(TranslatorAdded(result));
    });
  }
}
