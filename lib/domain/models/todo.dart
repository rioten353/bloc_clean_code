class Todo {
  final int id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  Todo toggleCompleted() {
    return Todo(
      id: id,
      title: title,
      isCompleted: !isCompleted,
    );
  }
}
