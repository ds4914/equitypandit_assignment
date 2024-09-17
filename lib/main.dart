import 'package:assignment/presentation/pages/homescreen/home_screen.dart';
import 'package:assignment/shared.dart';
import 'package:assignment/shared/widgets/fade_page_route_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        title: 'Assignment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes;
          WidgetBuilder? builder = routes[settings.name];
          if (builder != null) {
            return FadePageRouteBuilder(
              builder: builder,
              settings: settings,
            );
          }
          return null;
        },
        routes: Routes.getRoutes,
        home: HomeScreen(),
      ),
    );
  }
}
