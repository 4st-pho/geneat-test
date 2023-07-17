part of 'active_todo_count_cubit.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState(this.activeTodoCount);

  factory ActiveTodoCountState.inital() {
    return const ActiveTodoCountState(0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({int? activeTodoCount}) {
    return ActiveTodoCountState(activeTodoCount ?? this.activeTodoCount);
  }
}
