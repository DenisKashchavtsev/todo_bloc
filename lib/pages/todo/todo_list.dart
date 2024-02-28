import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_weather_bloc/services/navigation_service.dart';

import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo_list/todo_list_bloc.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = context.read<TodoBloc>();
    final TodoListBloc todoListBloc = context.read<TodoListBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        actions: [
          ElevatedButton(
              onPressed: () => {NavigationService().openAddTodo()},
              child: const Text('Add'))
        ],
      ),
      body: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          if (state is TodoListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoListInitial) {
            return const Text('List is empty');
          }

          if (state is TodoListLoaded) {
            return ListView.builder(
              itemCount: state.todo.length,
              itemBuilder: (context, index) {
                final todo = state.todo[index];
                return Opacity(
                  opacity: state.todo[index].isDone ? 0.6 : 1,
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Checkbox(
                              value: state.todo[index].isDone,
                              onChanged: (bool? value) {
                                todoBloc.add(UpdateTodoEvent(
                                    key: index,
                                    title: state.todo[index].title,
                                    description: state.todo[index].description,
                                    category: state.todo[index].category,
                                    isDone: value!));

                                todoListBloc.add(LoadTodoEvent());
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('done: ${todo.isDone}'),
                            Text('id: ${index.toString()}'),
                            Text('title: ${todo.title}'),
                            Text('description: ${todo.description}'),
                            Text('category: ${todo.category}'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => {
                                todoBloc.add(DeleteTodoEvent(key: index)),
                                todoListBloc.add(LoadTodoEvent())
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () =>
                                  {NavigationService().openUpdateTodo(index)},
                              icon: const Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
