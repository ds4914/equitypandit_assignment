import 'package:assignment/presentation/pages/add_task_screen.dart';
import 'package:assignment/presentation/pages/homescreen/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes = {
    "/homeScreen": (context) => HomeScreen(),
    "/addTaskScreen": (context) => AddTaskScreen(),
  };
}
