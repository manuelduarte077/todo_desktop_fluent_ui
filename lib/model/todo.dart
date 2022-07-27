class Todo {
  String _title;
  String _description;
  bool _isFinished;

  static List<Todo> todoList = [];

  Todo({
    required String title,
    required String description,
    required bool isFinished,
  })  : _title = title,
        _description = description,
        _isFinished = isFinished;

  get title => _title;

  set title(value) {
    _title = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
  }

  get isFinished => _isFinished;

  set isFinished(value) {
    _isFinished = value;
  }
}
