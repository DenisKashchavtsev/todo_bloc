part of 'todo_bloc.dart';

abstract class TodoEvent {}

class GetTodoEvent extends TodoEvent {
  final int id;

  GetTodoEvent({required this.id});
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final String category;
  final bool isDone;

  AddTodoEvent(
      {required this.title,
      required this.description,
      required this.category,
      required this.isDone});
}

class UpdateTodoEvent extends TodoEvent {
  final int key;
  final String title;
  final String description;
  final String category;
  final bool isDone;

  UpdateTodoEvent(
      {required this.key,
        required this.title,
        required this.description,
        required this.category,
        required this.isDone});
}

class DeleteTodoEvent extends TodoEvent {
  final int key;

  DeleteTodoEvent({required this.key});
}
