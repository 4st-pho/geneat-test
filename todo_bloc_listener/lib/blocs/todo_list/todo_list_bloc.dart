import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_bloc_listener/models/todo.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends HydratedBloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<TodoListItemAdded>(_addItem);
    on<TodoListItemEdited>(_editItem);
    on<TodoListItemRemoved>(_removeItem);
    on<TodoListItemToggled>(_toggleItem);
  }

  Future<void> _addItem(
    TodoListItemAdded event,
    Emitter<TodoListState> emit,
  ) async {
    final todos = [...state.todos, Todo(content: event.content)];
    emit(state.copyWith(todos: todos));
  }

  Future<void> _removeItem(
    TodoListItemRemoved event,
    Emitter<TodoListState> emit,
  ) async {
    final todos = state.todos.where((todo) => todo.id != event.id).toList();
    emit(state.copyWith(todos: todos));
  }

  Future<void> _editItem(
    TodoListItemEdited event,
    Emitter<TodoListState> emit,
  ) async {
    final todos = state.todos.map((todo) {
      if (todo.id == event.id) {
        return Todo(content: event.content, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: todos));
  }

  Future<void> _toggleItem(
    TodoListItemToggled event,
    Emitter<TodoListState> emit,
  ) async {
    final todos = state.todos.map((e) {
      if (e.id == event.id) {
        return Todo(id: e.id, content: e.content, isCompleted: !e.isCompleted);
      }
      return e;
    }).toList();
    emit(state.copyWith(todos: todos));
  }

  @override
  TodoListState? fromJson(Map<String, dynamic> json) {
    return TodoListState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoListState state) {
    return state.toJson();
  }
}
