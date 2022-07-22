import 'package:fluent_ui/fluent_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Center(
          child: Column(
        children: [
          Text('One'),
          Text('Two'),
        ],
      )),
    );
  }
}
