import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription todolistSubscription;
  final TodoListBloc todoListBloc;

  ActiveTodoCountBloc({required this.todoListBloc})
      : super(ActiveTodoCountState.inital()) {
    on<ActiveTodoCountUpdated>(_updateActiveTodoCount);
    registerListener();
    add(ActiveTodoCountUpdated());
  }
  void registerListener() {
    todolistSubscription =
        todoListBloc.stream.listen((_) => add(ActiveTodoCountUpdated()));
  }

  Future<void> _updateActiveTodoCount(
    ActiveTodoCountUpdated event,
    Emitter<ActiveTodoCountState> emit,
  ) async {
    final activeTodoCount =
        todoListBloc.state.todos.where((e) => !e.isCompleted).length;
    emit(state.copyWith(activeTodoCount: activeTodoCount));
  }

  @override
  Future<void> close() {
    todolistSubscription.cancel();
    return super.close();
  }
}
