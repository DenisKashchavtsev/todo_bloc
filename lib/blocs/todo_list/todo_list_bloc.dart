import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_weather_bloc/models/todo.dart';
import 'package:todo_weather_bloc/repositories/todo_repository.dart';

part 'todo_list_event.dart';

part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoRepository todoRepository;

  TodoListBloc(this.todoRepository) : super(TodoListInitial()) {
    on<LoadTodoEvent>(_load);

    init();
  }
  void init() {
    add(LoadTodoEvent());
  }

  Future<FutureOr<void>> _load(LoadTodoEvent event, Emitter<TodoListState> emit) async {
    emit(TodoListLoading());
    try {
      emit(TodoListLoaded(await todoRepository.getAllData()));
    } catch (_) {
      emit(TodoListInitial());
    }
  }
}
