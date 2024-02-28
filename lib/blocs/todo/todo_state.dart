part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final Todo? todo;

  TodoLoaded({required this.todo});
}

class TodoAdded extends TodoState {}

class TodoUpdated extends TodoState {}

class TodoDeleted extends TodoState {}

class TodoValidationError extends TodoState {}

class TodoError extends TodoState {}
