import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription todolistSubscription;
  final TodoListCubit todoListCubit;

  ActiveTodoCountCubit(this.todoListCubit)
      : super(ActiveTodoCountState.inital()) {
    todolistSubscription =
        todoListCubit.stream.listen((_) => updateActiveTodoCount());
    updateActiveTodoCount();
  }

  void updateActiveTodoCount() {
    final activeTodoCount =
        todoListCubit.state.todos.where((e) => !e.isCompleted).length;
    emit(state.copyWith(activeTodoCount: activeTodoCount));
  }

  @override
  Future<void> close() {
    todolistSubscription.cancel();
    return super.close();
  }
}
