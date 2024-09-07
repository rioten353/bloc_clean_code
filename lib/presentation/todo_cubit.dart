import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/todo.dart';
import '../domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todos = await todoRepo.getTodo();
    emit(todos);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().microsecond,
      title: text,
      isCompleted: false,
    );
    await todoRepo.addTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletions(Todo todo) async {
    final updateTodo = todo.toggleCompleted();
    await todoRepo.updateTodo(updateTodo);
    loadTodos();
  }
}
