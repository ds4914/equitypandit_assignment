import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../database/db_helper.dart';

part 'tasklist_event.dart';
part 'tasklist_state.dart';

class TasklistBloc extends Bloc<TasklistEvent, TasklistState> {
  DatabaseHelper dbHelper = DatabaseHelper();
  TasklistBloc() : super(TasklistInitial()) {
    on<GetTaskList>((event, emit) async {
      emit(TasklistLoadedState(await dbHelper.getTasks()));
    });
    on<AddTaskEvent>((event, emit) async {
      List<Map<String, dynamic>> taskList = await dbHelper.getTasks();
      Map<String, dynamic> newTask = {
        'title': event.title,
        'description': event.description,
        'statusID': event.statusId
      };
      await dbHelper.insertTask(newTask);
      emit(TasklistLoadedState(taskList));
    });
    on<UpdateTaskEvent>((event, emit) async {
      List<Map<String, dynamic>> taskList = await dbHelper.getTasks();
      Map<String, dynamic> task = {
        'title': event.title,
        'description': event.description,
        'statusID': event.statusId
      };
      await dbHelper.updateTask(task, event.id!);
      emit(TasklistLoadedState(taskList));
    });
  }
}
