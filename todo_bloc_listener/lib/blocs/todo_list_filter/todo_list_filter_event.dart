part of 'todo_list_filter_bloc.dart';

abstract class TodoListFilterEvent extends Equatable {
  const TodoListFilterEvent();

  @override
  List<Object> get props => [];
}

class TodoListFilterDependentChanged extends TodoListFilterEvent {
  final List<Todo> todos;
  final TodoTab tab;
  final String searchKeyword;
  const TodoListFilterDependentChanged({
    required this.todos,
    required this.tab,
    required this.searchKeyword,
  });
  @override
  List<Object> get props => [todos, tab, searchKeyword];
}
