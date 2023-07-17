part of 'todo_tab_bloc.dart';

class TodoTabState extends Equatable {
  final TodoTab tab;

  const TodoTabState(this.tab);
  factory TodoTabState.initial() {
    return const TodoTabState(TodoTab.all);
  }

  @override
  List<Object> get props => [tab];

  TodoTabState copyWith({TodoTab? tab}) {
    return TodoTabState(tab ?? this.tab);
  }
}
