import 'package:isar/isar.dart';

import '../../domain/models/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String title;
  late bool isCompleted;

  Todo toDomain() {
    return Todo(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }

  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..title = todo.title
      ..isCompleted = todo.isCompleted;
  }
}
