part of 'checkbox_bloc.dart';

@immutable
sealed class CheckboxState {}

final class CheckboxInitial extends CheckboxState {
  bool? isChecked;
  CheckboxInitial(this.isChecked);
}

