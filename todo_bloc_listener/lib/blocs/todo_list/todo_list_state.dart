part of 'todo_list_bloc.dart';

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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'todos': todos.map((x) => x.toJson()).toList(),
    };
  }

  factory TodoListState.fromJson(Map<String, dynamic> json) {
    return TodoListState(
      List<dynamic>.from(json['todos'])
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
