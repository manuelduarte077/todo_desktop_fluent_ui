import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:todo_desktop/database/database.dart';

import 'package:todo_desktop/widgets/widgets.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: navAppBar(),
      pane: _navigationPane(),
      content: _navigationBody(selectIndex: selectIndex),
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
            // source: Text(Todo.todoList.length.toString()),
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
      actions: Row(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              child: const Text('Create Tood'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddEditTodoContent(
                      onCreated: () {
                        setState(() {});
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  MediaQuery _navigationBody({
    required int selectIndex,
  }) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: NavigationBody(
        index: selectIndex,
        children: [
          _getListTodo(),
          Container(
            child: const Center(
              child: Text('Settings'),
            ),
          ),
        ],
      ),
    );
  }

  _getListTodo() {
    return FutureBuilder<List<TodoData>>(
      future: Provider.of<AppDatabase>(context, listen: false).getAllTodo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddEditTodoContent(
                            todo: snapshot.data![index],
                            onUpdated: () {
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: const Icon(FluentIcons.task_group),
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].description),
                      trailing: IconButton(
                        icon: const Icon(FluentIcons.delete),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ContentDialog(
                                  title: const Text('Deltete Todo'),
                                  content: const Text(
                                    'Are you sure want to delete this todo?',
                                  ),
                                  actions: [
                                    FilledButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(FluentIcons.delete),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text('Delete'),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              }).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: ProgressRing(),
        );
      },
    );
  }
}
