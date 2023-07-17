part of 'todo_tab_filter_cubit.dart';

class TodoTabFilterState extends Equatable {
  final TodoTabFilter todoTabFilter;

  const TodoTabFilterState(this.todoTabFilter);

  factory TodoTabFilterState.initial() {
    return const TodoTabFilterState(TodoTabFilter.all);
  }

  @override
  List<Object> get props => [todoTabFilter];

  TodoTabFilterState copyWith({TodoTabFilter? todoTabFilter}) {
    return TodoTabFilterState(todoTabFilter ?? this.todoTabFilter);
  }
}
