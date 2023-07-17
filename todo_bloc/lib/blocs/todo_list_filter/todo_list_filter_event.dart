part of 'todo_list_filter_bloc.dart';

abstract class TodoListFilterEvent extends Equatable {
  const TodoListFilterEvent();

  @override
  List<Object> get props => [];
}

class TodoListFilterDependentChanged extends TodoListFilterEvent {
  @override
  List<Object> get props => [];
}
