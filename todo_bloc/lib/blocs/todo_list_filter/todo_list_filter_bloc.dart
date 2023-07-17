import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_bloc/blocs/todo_tab/todo_tab_bloc.dart';
import 'package:todo_bloc/enums/todo_tab_filter.dart';
import 'package:todo_bloc/models/todo.dart';

part 'todo_list_filter_event.dart';
part 'todo_list_filter_state.dart';

class TodoListFilterBloc
    extends Bloc<TodoListFilterEvent, TodoListFilterState> {
  late final StreamSubscription todolistSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoTabSubscription;
  final TodoListBloc todoListBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoTabBloc todoTabBloc;

  TodoListFilterBloc({
    required this.todoListBloc,
    required this.todoSearchBloc,
    required this.todoTabBloc,
  }) : super(TodoListFilterState.initial()) {
    on<TodoListFilterDependentChanged>(_updateTodoListFilter);
    registerListener();
    add(TodoListFilterDependentChanged());
  }

  void registerListener() {
    todolistSubscription = todoListBloc.stream
        .listen((_) => add(TodoListFilterDependentChanged()));
    todoSearchSubscription = todoSearchBloc.stream
        .listen((_) => add(TodoListFilterDependentChanged()));
    todoTabSubscription =
        todoTabBloc.stream.listen((_) => add(TodoListFilterDependentChanged()));
  }

  Future<void> _updateTodoListFilter(
    TodoListFilterDependentChanged event,
    Emitter<TodoListFilterState> emit,
  ) async {
    var filterList = todoListBloc.state.todos;
    var tab = todoTabBloc.state.tab;
    String searchKeyrord = todoSearchBloc.state.keyword.toLowerCase().trim();

    if (searchKeyrord.isNotEmpty) {
      filterList = filterList
          .where((e) => e.content.toLowerCase().contains(searchKeyrord))
          .toList();
    }

    if (tab == TodoTab.active) {
      filterList = filterList.where((e) => !e.isCompleted).toList();
    } else if (tab == TodoTab.completed) {
      filterList = filterList.where((e) => e.isCompleted).toList();
    }
    emit(state.copyWith(todos: filterList));
  }

  @override
  Future<void> close() {
    todoTabSubscription.cancel();
    todoSearchSubscription.cancel();
    todolistSubscription.cancel();
    return super.close();
  }
}
