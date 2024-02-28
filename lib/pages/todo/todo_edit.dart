import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_weather_bloc/blocs/todo/todo_bloc.dart';
import 'package:todo_weather_bloc/services/navigation_service.dart';

import '../../blocs/todo_list/todo_list_bloc.dart';

class TodoEdit extends StatefulWidget {
  const TodoEdit({Key? key}) : super(key: key);

  @override
  State<TodoEdit> createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final TodoBloc todoBloc = context.read<TodoBloc>();

    todoBloc.add(GetTodoEvent(id: arguments['key']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<TodoBloc, TodoState>(
            builder: (BuildContext context, TodoState state) {
              if (state is TodoUpdated) {
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

              if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TodoLoaded) {

                _titleController.text = state.todo!.title;
                _descriptionController.text = state.todo!.description;
                _categoryController.text = state.todo!.category;

                return Column(
                  children: [
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
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () => {
                          todoBloc.add(UpdateTodoEvent(
                              key: arguments['key'],
                              title: _titleController.text,
                              description: _descriptionController.text,
                              category: _categoryController.text,
                              isDone: state.todo!.isDone))
                        },
                        child: const Text('Send'))
                  ],
                );
              }

              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
