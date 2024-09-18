import 'package:assignment/presentation/pages/homescreen/widgets/task_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/shared.dart';
import '../../../shared/widgets/common_appbar.dart';
import '../../../shared/widgets/common_button.dart';
import '../../bloc/checkbox_bloc/checkbox_bloc.dart';
import '../../bloc/radio_bloc/radio_bloc.dart';
import 'bloc/task_list_bloc/tasklist_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  DatabaseHelper dbHelper = DatabaseHelper();

  List<CheckboxBloc> checkboxBloc = [];
  TasklistBloc tasklistBloc = TasklistBloc()..add(GetTaskList());
  RadioBloc radioBloc = RadioBloc()..add(RadioButtonEvent("2"));

  String selectedValue = "2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CommonAppbar(
          title: Strings.homeScreen,
          showBackIcon: false,
          actions: [
            GestureDetector(
              onTap: () {
                filterBottomSheet(context);
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.white)),
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ),
              ).paddingRight(10.w),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteList.addTaskScreen, arguments: dbHelper).then((_) {
                  tasklistBloc.add(GetTaskList()); // Refresh the task list after returning from addTaskScreen
                });
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.white)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ).paddingRight(20.w),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<TasklistBloc, TasklistState>(
            bloc: tasklistBloc,
            builder: (context, state) {
              if (state is TasklistLoadedState) {
                return Expanded(
                  child: state.taskList.isEmpty
                      ? const Center(
                          child: Text(Strings.noTasksFound),
                        )
                      : ListView.builder(
                          itemCount: state.taskList.length,
                          itemBuilder: (context, index) {
                            checkboxBloc.add(CheckboxBloc());
                            return TaskCard(
                              data: state.taskList[index],
                              index: index,
                              checkboxBloc: checkboxBloc,
                              tasklistBloc: tasklistBloc,
                            );
                          },
                        ),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }

  Future<void> filterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: BlocBuilder<RadioBloc, RadioState>(
              bloc: radioBloc,
              builder: (context, state) {
                if (state is RadioInitial) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        Strings.filterList,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          radioBloc.add(RadioButtonEvent("2"));
                        },
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4.0, horizontal: -4.0),
                          title: const Text(Strings.all),
                          leading: Radio<String>(
                            value: '2',
                            groupValue: state.value,
                            onChanged: (value) {
                              radioBloc.add(RadioButtonEvent(value.toString()));
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          radioBloc.add(RadioButtonEvent("1"));
                        },
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4.0, horizontal: -4.0),
                          title: const Text(Strings.completed),
                          leading: Radio<String>(
                            value: '1',
                            groupValue: state.value,
                            onChanged: (value) {
                              radioBloc.add(RadioButtonEvent(value.toString()));
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          radioBloc.add(RadioButtonEvent("0"));
                        },
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4.0, horizontal: -4.0),
                          title: const Text(Strings.notCompleted),
                          leading: Radio<String>(
                            value: '0',
                            groupValue: state.value,
                            onChanged: (value) {
                              radioBloc.add(RadioButtonEvent(value.toString()));
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                                color: Colors.white,
                                textColor: Colors.black,
                                title: Strings.cancel,
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: CommonButton(
                                title: Strings.apply,
                                onTap: () {
                                  tasklistBloc.add(FilterTaskEvent(statusId: int.tryParse(state.value!)));
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          );
        });
  }
}
