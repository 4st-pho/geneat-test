import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_cubit_listener/models/todo.dart';

part 'todo_list_state.dart';

class TodoListCubit extends HydratedCubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String content) {
    final todos = [...state.todos, Todo(content: content)];
    emit(state.copyWith(todos: todos));
  }

  void removeTodo(String id) {
    final todos = state.todos.where((todo) => todo.id != id).toList();
    emit(state.copyWith(todos: todos));
  }

  void editTodo(String id, String content) {
    final todos = state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(content: content, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: todos));
  }

  void toggleTodoStatus(String id) {
    final todos = state.todos.map((e) {
      if (e.id == id) {
        return Todo(id: e.id, content: e.content, isCompleted: !e.isCompleted);
      }
      return e;
    }).toList();
    emit(state.copyWith(todos: todos));
  }

  @override
  TodoListState? fromJson(Map<String, dynamic> json) {
    return TodoListState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoListState state) {
    return state.toMap();
  }
}
