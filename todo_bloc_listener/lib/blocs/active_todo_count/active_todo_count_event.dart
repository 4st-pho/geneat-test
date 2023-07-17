part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

class ActiveTodoCountValueSet extends ActiveTodoCountEvent {
  final int activeTodoCount;
  const ActiveTodoCountValueSet({
    required this.activeTodoCount,
  });

  @override
  List<Object> get props => [activeTodoCount];
}
