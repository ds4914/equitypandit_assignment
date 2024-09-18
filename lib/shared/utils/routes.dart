import 'package:assignment/presentation/pages/add_task_screen.dart';
import 'package:assignment/presentation/pages/homescreen/home_screen.dart';
import 'package:assignment/shared/shared.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes = {
    RouteList.homeScreen: (context) => HomeScreen(),
    RouteList.addTaskScreen: (context) => AddTaskScreen(),
  };
}
