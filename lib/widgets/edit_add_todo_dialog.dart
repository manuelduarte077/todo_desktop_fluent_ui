import 'package:fluent_ui/fluent_ui.dart';
import 'package:todo_desktop/model/todo.dart';

class AddEditTodoContent extends StatefulWidget {
  const AddEditTodoContent({Key? key}) : super(key: key);

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Create Todo'),
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
        FilledButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(FluentIcons.save),
              SizedBox(
                width: 8,
              ),
              Text('Save'),
            ],
          ),
          onPressed: () {
            String title = titleContoller.text;
            String desc = descriptionController.text;
            Todo.todoList.add(
              Todo(title: title, description: desc, isFinished: isFinished),
            );
          },
        )
      ],
    );
  }
}
