import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_weather_bloc/models/todo.dart';
import 'package:todo_weather_bloc/services/navigation_service.dart';

import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo_list/todo_list_bloc.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  late bool _isChecked = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = context.read<TodoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            BlocBuilder<TodoBloc, TodoState>(
                builder: (BuildContext context, TodoState state) {
              if (state is TodoAdded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Success!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                });

                NavigationService().back();
              }

              return const SizedBox.shrink();
            }),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'title',
              ),
              controller: _titleController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'description',
              ),
              controller: _descriptionController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'category',
              ),
              controller: _categoryController,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () => {
                      todoBloc.add(AddTodoEvent(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          category: _categoryController.text,
                          isDone: _isChecked ? true : false))
                    },
                child: const Text('Send'))
          ],
        ),
      ),
    );
  }
}
