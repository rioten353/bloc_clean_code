import '../models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodo();

  Future<void> addTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Future<void> updateTodo(Todo todo);
}
