part of 'tasklist_bloc.dart';

@immutable
sealed class TasklistEvent {}

class GetTaskList extends TasklistEvent {
  GetTaskList();
}

class AddTaskEvent extends TasklistEvent {
  final String? title;
  final String? description;
  final int? statusId;
  AddTaskEvent({this.title, this.description, this.statusId});
}

class UpdateTaskEvent extends TasklistEvent {
  final String? title;
  final String? description;
  final int? statusId;
  final int? id;
  UpdateTaskEvent({this.title, this.id, this.description, this.statusId});
}

class DeleteTaskEvent extends TasklistEvent {
  final int? id;
  DeleteTaskEvent({this.id});
}

class FilterTaskEvent extends TasklistEvent {
  final int? statusId;
  FilterTaskEvent({this.statusId});
}