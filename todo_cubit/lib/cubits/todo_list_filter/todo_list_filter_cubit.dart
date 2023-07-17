import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit/cubits/todo_tab_filter/todo_tab_filter_cubit.dart';
import 'package:todo_cubit/enums/todo_tab_filter.dart';
import 'package:todo_cubit/models/todo.dart';

part 'todo_list_filter_state.dart';

class TodoListFilterCubit extends Cubit<TodoListFilterState> {
  late final StreamSubscription todolistSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoTabFilterSubscription;
  final TodoListCubit todoListCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoTabFilterCubit todoTabFilterCubit;

  TodoListFilterCubit({
    required this.todoListCubit,
    required this.todoSearchCubit,
    required this.todoTabFilterCubit,
  }) : super(TodoListFilterState.initial()) {
    todolistSubscription = todoListCubit.stream.listen(updateFilterTodoList);
    todoSearchSubscription =
        todoSearchCubit.stream.listen(updateFilterTodoList);
    todoTabFilterSubscription =
        todoTabFilterCubit.stream.listen(updateFilterTodoList);
    updateFilterTodoList('');
  }

  void updateFilterTodoList(_) {
    var filterList = todoListCubit.state.todos;
    var tabFilter = todoTabFilterCubit.state.todoTabFilter;
    String todoSearchKeyrord =
        todoSearchCubit.state.keyword.toLowerCase().trim();

    if (todoSearchKeyrord.isNotEmpty) {
      filterList = filterList
          .where((e) => e.content.toLowerCase().contains(todoSearchKeyrord))
          .toList();
    }

    if (tabFilter == TodoTabFilter.active) {
      filterList = filterList.where((e) => !e.isCompleted).toList();
    } else if (tabFilter == TodoTabFilter.completed) {
      filterList = filterList.where((e) => e.isCompleted).toList();
    }
    emit(state.copyWith(todos: filterList));
  }

  @override
  Future<void> close() {
    todoTabFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todolistSubscription.cancel();
    return super.close();
  }
}
