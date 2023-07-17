part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class TodoListItemAdded extends TodoListEvent {
  final String content;
  const TodoListItemAdded({required this.content});

  @override
  List<Object> get props => [content];
}

class TodoListItemRemoved extends TodoListEvent {
  final String id;
  const TodoListItemRemoved({required this.id});

  @override
  List<Object> get props => [id];
}

class TodoListItemToggled extends TodoListEvent {
  final String id;
  const TodoListItemToggled({required this.id});

  @override
  List<Object> get props => [id];
}

class TodoListItemEdited extends TodoListEvent {
  final String id;
  final String content;
  const TodoListItemEdited({required this.content, required this.id});

  @override
  List<Object> get props => [id, content];
}
