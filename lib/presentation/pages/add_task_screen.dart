import 'package:assignment/presentation/pages/homescreen/bloc/task_list_bloc/tasklist_bloc.dart';
import 'package:assignment/shared/widgets/common_appbar.dart';
import 'package:assignment/shared/widgets/common_button.dart';
import 'package:assignment/shared/widgets/common_text_field.dart';

import '../../shared/shared.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TasklistBloc tasklistBloc = TasklistBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: const CommonAppbar(
            title: Strings.addTaskScreen,
            showBackIcon: true,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonTextfield(controller: titleController, title: "Title"),
            CommonTextfield(
              controller: descController,
              title: Strings.description,
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonButton(
                title: Strings.submit,
                onTap: () async {
                  if (titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(Strings.titleIsRequired),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(Strings.taskAddedSuccessfully),
                      backgroundColor: Colors.red,
                    ));
                    tasklistBloc
                        .add(AddTaskEvent(description: descController.text, title: titleController.text, statusId: 0));
                    Navigator.pushNamedAndRemoveUntil(context, RouteList.homeScreen, (route) => false);
                  }
                }).paddingSymmetric(horizontal: 20.w)
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
      ),
    );
  }
}
