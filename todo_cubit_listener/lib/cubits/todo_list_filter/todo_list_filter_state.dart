part of 'todo_list_filter_cubit.dart';

class TodoListFilterState extends Equatable {
  final List<Todo> todos;

  const TodoListFilterState(this.todos);

  factory TodoListFilterState.initial() {
    return const TodoListFilterState([]);
  }

  @override
  List<Object> get props => [todos];

  TodoListFilterState copyWith({List<Todo>? todos}) {
    return TodoListFilterState(todos ?? this.todos);
  }
}
