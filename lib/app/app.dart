import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:todo_desktop/database/database.dart';
import 'package:todo_desktop/screens/todo/todo_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: const FluentApp(
        home: TodoScreen(),
      ),
    );
  }
}
