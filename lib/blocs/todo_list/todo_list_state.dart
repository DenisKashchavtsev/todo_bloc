part of 'todo_list_bloc.dart';

abstract class TodoListState {}

class TodoListInitial extends TodoListState {}

class TodoListLoading extends TodoListState {}

class TodoListLoaded extends TodoListState {
  final List<Todo> todo;

  TodoListLoaded(this.todo);
}