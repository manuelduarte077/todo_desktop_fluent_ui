import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:todo_desktop/database/database.dart';

import 'package:drift/drift.dart' as d;

class AddEditTodoContent extends StatefulWidget {
  const AddEditTodoContent({
    Key? key,
    this.onCreated,
    this.onUpdated,
    this.todo,
  }) : super(key: key);

  final Function? onCreated;
  final Function? onUpdated;

  final TodoData? todo;

  @override
  State<AddEditTodoContent> createState() => _AddEditTodoContentState();
}

class _AddEditTodoContentState extends State<AddEditTodoContent> {
  late TextEditingController titleContoller;
  late TextEditingController descriptionController;

  bool isFinished = false;

  @override
  void initState() {
    titleContoller = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.todo != null) {
      // descriptionController.text = widget.todo!.description;
      // titleContoller.text = widget.todo!.title;
      // isFinished = widget.todo!.isFinished;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: ContentDialog(
        title: Text(widget.todo != null ? 'Updated Todo' : 'Create Todo'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBox(
              controller: titleContoller,
              placeholder: 'Title',
            ),
            const SizedBox(
              height: 16,
            ),
            TextBox(
              controller: descriptionController,
              placeholder: 'Description',
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(
              height: 16,
            ),
            Checkbox(
              content: const Text('Finished?'),
              checked: isFinished,
              onChanged: (value) {
                setState(() {
                  isFinished = !isFinished;
                });
              },
            )
          ],
        ),
        actions: [
          TextButton(
            child: const Icon(FluentIcons.chrome_close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (widget.todo != null) ...[
            FilledButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(FluentIcons.save),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Updated'),
                ],
              ),
              onPressed: () {
                String title = titleContoller.text;
                String desc = descriptionController.text;

                // int index = Todo.todoList.indexOf(widget.todo!);

                // Todo.todoList[index] = Todo(
                //   title: title,
                //   description: desc,
                //   isFinished: isFinished,
                // );

                widget.onUpdated!();
                Navigator.of(context).pop();
              },
            )
          ] else ...[
            FilledButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(FluentIcons.save),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Create'),
                ],
              ),
              onPressed: () {
                String title = titleContoller.text;
                String desc = descriptionController.text;

                Provider.of<AppDatabase>(context, listen: false).insertTodo(
                  TodoCompanion(
                    title: d.Value(title),
                    description: d.Value(desc),
                    isFinished: d.Value(isFinished),
                  ),
                );

                widget.onCreated!();
              },
            )
          ],
        ],
      ),
    );
  }
}
