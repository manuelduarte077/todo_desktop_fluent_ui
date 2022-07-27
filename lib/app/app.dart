import 'package:fluent_ui/fluent_ui.dart';
import 'package:todo_desktop/screens/home/home_screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      home: HomeScreen(),
    );
  }
}
