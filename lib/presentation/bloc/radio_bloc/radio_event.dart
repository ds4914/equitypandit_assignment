part of 'radio_bloc.dart';

@immutable
sealed class RadioEvent {}


class RadioButtonEvent extends RadioEvent{
  final String value;
  RadioButtonEvent(this.value);
}