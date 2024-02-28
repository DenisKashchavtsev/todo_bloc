import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/todo.dart';
import '../../../repositories/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<GetTodoEvent>(_get);
    on<AddTodoEvent>(_add);
    on<UpdateTodoEvent>(_update);
    on<DeleteTodoEvent>(_delete);
  }

  Future<FutureOr<void>> _get(
      GetTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      Todo? todo = await todoRepository.getData(event.id);
      emit(TodoLoaded(todo: todo));
    } catch (_) {
      emit(TodoError());
    }
  }

  FutureOr<void> _add(AddTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    try {
      todoRepository.addData(Todo(
          title: event.title,
          description: event.description,
          category: event.category,
          isDone: event.isDone));

      emit(TodoAdded());
    } catch (_) {
      emit(TodoError());
    }
  }

  FutureOr<void> _update(UpdateTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    try {

      todoRepository.updateData(event.key, Todo(
          title: event.title,
          description: event.description,
          category: event.category,
          isDone: event.isDone));

      emit(TodoUpdated());
    } catch (_) {
      emit(TodoError());
    }
  }

  FutureOr<void> _delete(DeleteTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    try {
      todoRepository.deleteData(event.key);

      emit(TodoDeleted());
    } catch (_) {
      emit(TodoError());
    }
  }
}
