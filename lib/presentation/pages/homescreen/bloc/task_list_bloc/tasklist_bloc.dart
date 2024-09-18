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
      Map<String, dynamic> newTask = {
        'title': event.title,
        'description': event.description,
        'statusID': event.statusId
      };
      await dbHelper.insertTask(newTask);
      List<Map<String, dynamic>> taskList = await dbHelper.getTasks();
      emit(TasklistLoadedState(taskList));
    });
    on<UpdateTaskEvent>((event, emit) async {
      Map<String, dynamic> task = {'title': event.title, 'description': event.description, 'statusID': event.statusId};
      await dbHelper.updateTask(task, event.id!);
      List<Map<String, dynamic>> taskList = await dbHelper.getTasks();
      emit(TasklistLoadedState(taskList));
    });
    on<DeleteTaskEvent>((event, emit) async {
      await dbHelper.deleteTask(event.id!);
      List<Map<String, dynamic>> taskList = await dbHelper.getTasks();
      emit(TasklistLoadedState(taskList));
    });

    on<FilterTaskEvent>((event, emit) async {
      List<Map<String,dynamic>> list = [];
      List<Map<String, dynamic>> taskList = await dbHelper.getTasks();
      if(event.statusId != 2){
        list.addAll(taskList.where((element)=>element['statusID']==event.statusId));
      }else{
        list.addAll(taskList);
      }
      emit(TasklistLoadedState(list));
    });
  }
}
