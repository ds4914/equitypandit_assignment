import 'package:assignment/presentation/pages/homescreen/bloc/task_list_bloc/tasklist_bloc.dart';
import 'package:assignment/shared/widgets/common_appbar.dart';
import 'package:assignment/shared/widgets/common_button.dart';
import 'package:assignment/shared/widgets/common_text_field.dart';

import '../../shared.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TasklistBloc tasklistBloc = TasklistBloc();
  @override
  Widget build(BuildContext context) {
    DatabaseHelper dbHelper =
        ModalRoute.of(context)!.settings.arguments as DatabaseHelper;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CommonAppbar(
            title: "Add Task Screen",
            showBackIcon: true,
          )),
      body: Column(
        children: [
          CommonTextfield(controller: titleController, title: "Title"),
          SizedBox(
            height: 5.h,
          ),
          CommonTextfield(
            controller: descController,
            title: "Description",
          ),
          SizedBox(
            height: 10.h,
          ),
          CommonButton(
              title: "Submit",
              onTap: () async {
                tasklistBloc.add(AddTaskEvent(
                    description: descController.text,
                    title: titleController.text,
                    statusId: 0));
                Navigator.pushNamedAndRemoveUntil(
                    context, "/homeScreen", (route) => false);
              }).paddingSymmetric(horizontal: 20.w)
        ],
      ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
    );
  }
}
