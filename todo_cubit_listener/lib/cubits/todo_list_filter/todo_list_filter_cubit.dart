import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_listener/enums/todo_tab_filter.dart';
import 'package:todo_cubit_listener/models/todo.dart';

part 'todo_list_filter_state.dart';

class TodoListFilterCubit extends Cubit<TodoListFilterState> {
  final List<Todo> allTodos;
  TodoListFilterCubit(this.allTodos) : super(TodoListFilterState.initial()) {
    updateFilterTodoList(
      todos: allTodos,
      todoTab: TodoTab.all,
      searchKeyword: '',
    );
  }

  void updateFilterTodoList({
    required List<Todo> todos,
    required TodoTab todoTab,
    required String searchKeyword,
  }) {
    searchKeyword = searchKeyword.toLowerCase().trim();
    if (searchKeyword.isNotEmpty) {
      todos = todos
          .where((e) => e.content.toLowerCase().contains(searchKeyword))
          .toList();
    }

    if (todoTab == TodoTab.active) {
      todos = todos.where((e) => !e.isCompleted).toList();
    } else if (todoTab == TodoTab.completed) {
      todos = todos.where((e) => e.isCompleted).toList();
    }
    emit(state.copyWith(todos: todos));
  }
}
