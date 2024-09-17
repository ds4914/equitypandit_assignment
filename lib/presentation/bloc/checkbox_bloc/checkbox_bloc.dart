import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkbox_event.dart';
part 'checkbox_state.dart';

class CheckboxBloc extends Bloc<CheckboxEvent, CheckboxState> {
  CheckboxBloc() : super(CheckboxInitial(false)) {
    on<CheckBoxClickEvent>((event, emit) {
      emit(CheckboxInitial(event.isChecked ? false : true));
    });
  }
}
