part of 'radio_bloc.dart';

@immutable
sealed class RadioState {}

final class RadioInitial extends RadioState {
  final String? value;
  RadioInitial({this.value});
}
