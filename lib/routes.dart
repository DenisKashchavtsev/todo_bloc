import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_weather_bloc/blocs/todo/todo_bloc.dart';
import 'package:todo_weather_bloc/pages/todo/todo_add.dart';
import 'package:todo_weather_bloc/pages/todo/todo_edit.dart';
import 'package:todo_weather_bloc/pages/todo/todo_list.dart';
import 'package:todo_weather_bloc/repositories/todo_repository.dart';

import 'blocs/todo_list/todo_list_bloc.dart';

class Routes {
  final BuildContext context;

  Routes(this.context);

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<TodoListBloc>(
                create: (context) => TodoListBloc(TodoRepository()),
              ),
              BlocProvider<TodoBloc>(
                create: (context) => TodoBloc(TodoRepository()),
              ),
            ],
            child: TodoList(),
          ),
      '/add-todo': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<TodoListBloc>(
                create: (context) => TodoListBloc(TodoRepository()),
              ),
              BlocProvider<TodoBloc>(
                create: (context) => TodoBloc(TodoRepository()),
              ),
            ],
            child: const TodoAdd(),
          ),
      '/edit-todo': (context) => MultiBlocProvider(
            providers: [
              BlocProvider<TodoListBloc>(
                create: (context) => TodoListBloc(TodoRepository()),
              ),
              BlocProvider<TodoBloc>(
                create: (context) => TodoBloc(TodoRepository()),
              ),
            ],
            child: const TodoEdit(),
          ),
    };
  }
}
