import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared.dart';
import '../../../shared/widgets/common_appbar.dart';
import '../../../shared/widgets/common_button.dart';
import '../../bloc/checkbox_bloc/checkbox_bloc.dart';
import 'bloc/task_list_bloc/tasklist_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  DatabaseHelper dbHelper = DatabaseHelper();

  List<CheckboxBloc> checkboxBloc = [];

  TasklistBloc tasklistBloc = TasklistBloc()..add(GetTaskList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CommonAppbar(
          title: "Home Screen",
          showBackIcon: false,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/addTaskScreen",
                        arguments: dbHelper)
                    .then((_) {
                  tasklistBloc.add(
                      GetTaskList()); // Refresh the task list after returning from addTaskScreen
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: Colors.white)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ).paddingRight(10.w),
            )
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
                          child: Text("No Tasks Found"),
                        )
                      : ListView.builder(
                          itemCount: state.taskList.length,
                          itemBuilder: (context, index) {
                            checkboxBloc.add(CheckboxBloc());
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.taskList[index]['title']),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: state.taskList[index]
                                                        ['statusId'] ==
                                                    1
                                                ? Colors.lightGreen
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5.r)),
                                        child: Text(
                                          state.taskList[index]['statusId'] == 1
                                              ? "Completed"
                                              : "Not Completed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.sp),
                                        ).paddingSymmetric(
                                            vertical: 5.h, horizontal: 10.w),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(state.taskList[index]
                                                  ['description'] ??
                                              "No Description")),
                                      Row(
                                        children: [
                                          BlocBuilder<CheckboxBloc,
                                              CheckboxState>(
                                            bloc: checkboxBloc[index],
                                            builder: (context, checkBoxState) {
                                              return Checkbox(
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: -4.0,
                                                        vertical: -4.0),
                                                value: (checkBoxState
                                                        is CheckboxInitial)
                                                    ? checkBoxState.isChecked
                                                    : false,
                                                activeColor: Colors.red,
                                                onChanged: (value) {
                                                  if (value == true) {
                                                    showModalBottomSheet(
                                                        enableDrag: false,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.r),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.r))),
                                                        context: context,
                                                        builder: (context) {
                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                    "Are you sure you want to complete this task?"),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: CommonButton(
                                                                          title: "No",
                                                                          onTap: () {
                                                                            Navigator.pop(context);
                                                                          }),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    Expanded(
                                                                      child: CommonButton(
                                                                          title: "Yes",
                                                                          color: Colors.lightGreen,
                                                                          onTap: () {
                                                                            tasklistBloc.add(UpdateTaskEvent(
                                                                                statusId: 1,
                                                                                description: state.taskList[index]['description'],
                                                                                title: state.taskList[index]['title'],
                                                                                id: state.taskList[index]['id']));
                                                                            checkboxBloc[index].add(CheckBoxClickEvent(value!
                                                                                ? false
                                                                                : true));
                                                                            Navigator.pop(context);
                                                                          }),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ).paddingSymmetric(
                                                                horizontal:
                                                                    20.w,
                                                                vertical: 10.h),
                                                          );
                                                        });
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                          const Text("Complete")
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ).paddingSymmetric(
                                  horizontal: 14.w, vertical: 5.h),
                            ).paddingSymmetric(horizontal: 14.w, vertical: 5.h);
                          },
                        ),
                );
              }
              return SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
