part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState(this.todos);

  factory TodoListState.initial() {
    return const TodoListState([]);
  }

  @override
  List<Object> get props => [todos];

  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(todos ?? this.todos);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todos': todos.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoListState.fromMap(Map<String, dynamic> map) {
    return TodoListState(List<dynamic>.from(map['todos'])
        .map((e) => Todo.fromMap(e as Map<String, dynamic>))
        .toList());
  }
}
