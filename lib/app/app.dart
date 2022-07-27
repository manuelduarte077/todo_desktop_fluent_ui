import 'package:fluent_ui/fluent_ui.dart';
import 'package:todo_desktop/screens/todo/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      home: TodoScreen(),
    );
  }
}
