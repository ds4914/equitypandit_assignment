part of 'checkbox_bloc.dart';

@immutable
sealed class CheckboxEvent {}

class CheckBoxClickEvent extends CheckboxEvent{
  final bool isChecked;
  CheckBoxClickEvent(this.isChecked);
}
