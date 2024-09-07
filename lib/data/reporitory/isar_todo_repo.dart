import 'package:isar/isar.dart';

import '../../data/models/isar_todo.dart';
import '../../domain/models/todo.dart';
import '../../domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;
  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);
    return await db.writeTxn(() async {
      await db.todoIsars.put(todoIsar);
    });
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);
    return await db.writeTxn(() async {
      await db.todoIsars.delete(todoIsar.id);
    });
  }

  @override
  Future<List<Todo>> getTodo() async {
    final todos = await db.todoIsars.where().findAll();

    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);
    return await db.writeTxn(() async {
      await db.todoIsars.put(todoIsar);
    });
  }
}
