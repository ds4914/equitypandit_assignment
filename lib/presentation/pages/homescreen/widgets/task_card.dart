import 'package:assignment/presentation/pages/homescreen/bloc/task_list_bloc/tasklist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/shared.dart';
import '../../../../shared/widgets/common_button.dart';
import '../../../bloc/checkbox_bloc/checkbox_bloc.dart';

class TaskCard extends StatelessWidget {
  final Map<String,dynamic> data;
  final int index;
  final List<CheckboxBloc> checkboxBloc;
  final TasklistBloc tasklistBloc;
  const TaskCard({super.key,required this.index,required this.tasklistBloc,required this.checkboxBloc,required this.data,required});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data['title'],
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: data['statusID'] == 1
                            ? Colors.lightGreen
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Text(
                      data['statusID'] == 1 ? Strings.completed : Strings.notCompleted,
                      style: TextStyle(
                          color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w700),
                    ).paddingSymmetric(
                        vertical: 5.h,
                        horizontal: data['statusID'] == 1 ? 20.w : 10.w),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            enableDrag: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r))),
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Text(Strings.areYouSureYouWantToDeleteThisTask),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonButton(
                                              title: Strings.no,
                                              color: Colors.lightGreen,
                                              onTap: () {
                                                Navigator.pop(context);
                                              }),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: CommonButton(
                                              title: Strings.yes,
                                              color: Colors.red,
                                              onTap: () {
                                                tasklistBloc.add(DeleteTaskEvent(
                                                    id: data['id']));
                                                Navigator.pop(context);
                                              }),
                                        )
                                      ],
                                    )
                                  ],
                                ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.red)),
                        child: Icon(
                          Icons.delete,
                          size: 22.sp,
                          color: Colors.red,
                        ),
                      ))
                ],
              )
            ],
          ),
          Row(
            children: [
              Expanded(child: Text(data['description'] ?? "No Description",style: TextStyle(fontSize: 13.sp),)),
              data['statusID'] == 0
                  ? Row(
                children: [
                  BlocBuilder<CheckboxBloc, CheckboxState>(
                    bloc: checkboxBloc[index],
                    builder: (context, checkBoxState) {
                      return Checkbox(
                        visualDensity:
                        const VisualDensity(horizontal: -4.0, vertical: -4.0),
                        value: data['statusID'] == 1 ? true : false,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          if (value == true) {
                            showModalBottomSheet(
                                enableDrag: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        topRight: Radius.circular(20.r))),
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Text(
                                            Strings.areYouSureYouWantToCompleteThisTask),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CommonButton(
                                                  title: Strings.no,
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                              child: CommonButton(
                                                  title: Strings.yes,
                                                  color: Colors.lightGreen,
                                                  onTap: () {
                                                    tasklistBloc.add(UpdateTaskEvent(
                                                        statusId: 1,
                                                        description: data
                                                        ['description'],
                                                        title: data
                                                        ['title'],
                                                        id: data['id']));
                                                    checkboxBloc[index].add(
                                                        CheckBoxClickEvent(
                                                            value! ? false : true));
                                                    Navigator.pop(context);
                                                  }),
                                            )
                                          ],
                                        )
                                      ],
                                    ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
                                  );
                                });
                          }
                        },
                      );
                    },
                  ),
                  const Text(Strings.complete)
                ],
              )
                  : const SizedBox.shrink()
            ],
          ).paddingRight(50.w),
        ],
      ).paddingSymmetric(horizontal: 14.w, vertical: 5.h),
    ).paddingSymmetric(horizontal: 14.w, vertical: 5.h);
  }
}
