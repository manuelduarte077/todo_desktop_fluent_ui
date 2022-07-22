import 'package:fluent_ui/fluent_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: navAppBar(),
      pane: _navigationPane(),
      content: WidgetNavigationBody(selectIndex: selectIndex),
    );
  }

  // Sidebar Navigation
  NavigationPane _navigationPane() {
    return NavigationPane(
      header: const FlutterLogo(
        style: FlutterLogoStyle.horizontal,
        size: 100,
      ),
      indicator: const EndNavigationIndicator(),
      selected: selectIndex,
      onChanged: (index) {
        setState(() {
          selectIndex = index;
        });
      },
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.to_do_logo_outline),
          title: const Text('List Todo'),
          infoBadge: InfoBadge(
            color: Colors.blue,
            source: const Text('10'),
          ),
        ),
      ],
      footerItems: [
        PaneItem(
          icon: const Icon(FluentIcons.settings),
          title: const Text('Settings'),
        ),
      ],
    );
  }

// AppBar
  NavigationAppBar navAppBar() {
    return NavigationAppBar(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Todo App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      actions: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Spacer(),
            OutlinedButton(
              child: const Text('Create Tood'),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}

class WidgetNavigationBody extends StatelessWidget {
  const WidgetNavigationBody({
    Key? key,
    required this.selectIndex,
  }) : super(key: key);

  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBody(
      index: selectIndex,
      children: [
        Container(
          child: const Center(
            child: Text('TODO List'),
          ),
        ),
        Container(
          child: const Center(
            child: Text('Settings'),
          ),
        ),
      ],
    );
  }
}
