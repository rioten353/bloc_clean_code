import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/todo.dart';
import '../todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          title: const Text('Todo App'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          splashColor: Colors.greenAccent,
          hoverColor: Colors.greenAccent.shade100,
          onPressed: () => _showAddTodoBox(context),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, todos) {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      color: todo.isCompleted ? Colors.grey : Colors.black,
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Checkbox(
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    value: todo.isCompleted,
                    onChanged: (value) =>
                        context.read<TodoCubit>().toggleCompletions(todo),
                  ),
                  trailing: IconButton(
                    color: Colors.red,
                    splashColor: Colors.redAccent,
                    hoverColor: Colors.redAccent.shade100,
                    iconSize: 25,
                    onPressed: () => context.read<TodoCubit>().deleteTodo(todo),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Todo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter a new todo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.red),
            ),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                todoCubit.addTodo(textController.text);
              }
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.green),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
