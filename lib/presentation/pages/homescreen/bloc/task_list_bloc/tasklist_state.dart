part of 'tasklist_bloc.dart';

@immutable
sealed class TasklistState {}

final class TasklistInitial extends TasklistState {}

final class TasklistLoadedState extends TasklistState {
  List<Map<String, dynamic>> taskList;
  TasklistLoadedState(this.taskList);
}
