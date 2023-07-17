import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_listener/enums/todo_tab_filter.dart';
import 'package:todo_bloc_listener/models/todo.dart';

part 'todo_list_filter_event.dart';
part 'todo_list_filter_state.dart';

class TodoListFilterBloc
    extends Bloc<TodoListFilterEvent, TodoListFilterState> {
  final List<Todo> allTodos;

  TodoListFilterBloc({required this.allTodos})
      : super(TodoListFilterState.initial()) {
    on<TodoListFilterDependentChanged>(_updateTodoListFilter);

    add(TodoListFilterDependentChanged(
      todos: allTodos,
      searchKeyword: '',
      tab: TodoTab.all,
    ));
  }

  Future<void> _updateTodoListFilter(
    TodoListFilterDependentChanged event,
    Emitter<TodoListFilterState> emit,
  ) async {
    final searchKeyword = event.searchKeyword.toLowerCase().trim();
    List<Todo> todos = event.todos;
    if (searchKeyword.isNotEmpty) {
      todos = todos
          .where((e) => e.content.toLowerCase().contains(searchKeyword))
          .toList();
    }

    if (event.tab == TodoTab.active) {
      todos = todos.where((e) => !e.isCompleted).toList();
    } else if (event.tab == TodoTab.completed) {
      todos = todos.where((e) => e.isCompleted).toList();
    }
    emit(state.copyWith(todos: todos));
  }
}
