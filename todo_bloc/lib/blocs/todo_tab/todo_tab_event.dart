part of 'todo_tab_bloc.dart';

abstract class TodoTabEvent extends Equatable {
  const TodoTabEvent();

  @override
  List<Object> get props => [];
}

class TodoTabSeted extends TodoTabEvent {
  final TodoTab tab;
  const TodoTabSeted({required this.tab});

  @override
  String toString() => 'TodoTabSeted(tab: $tab)';

  @override
  List<Object> get props => [tab];
}
