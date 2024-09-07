import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/isar_todo.dart';
import 'data/reporitory/isar_todo_repo.dart';
import 'domain/repository/todo_repo.dart';
import 'presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationCacheDirectory();

  final isar = await Isar.open(
    [TodoIsarSchema],
    directory: dir.path,
    inspector: true,
  );

  final isarTodoRepo = IsarTodoRepo(isar);

  runApp(
    MyApp(
      todoRepo: isarTodoRepo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(
        todoRepo: todoRepo,
      ),
    );
  }
}
