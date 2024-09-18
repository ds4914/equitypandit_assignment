import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'radio_event.dart';
part 'radio_state.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  RadioBloc() : super(RadioInitial()) {
    on<RadioButtonEvent>((event, emit) {
      emit(RadioInitial(value: event.value));
    });
  }
}
