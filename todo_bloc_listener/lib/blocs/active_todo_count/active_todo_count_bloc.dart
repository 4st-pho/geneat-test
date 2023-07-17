import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  final int activeTodoCount;

  ActiveTodoCountBloc({required this.activeTodoCount})
      : super(ActiveTodoCountState.inital()) {
    on<ActiveTodoCountValueSet>(_updateActiveTodoCount);
  }

  Future<void> _updateActiveTodoCount(
    ActiveTodoCountValueSet event,
    Emitter<ActiveTodoCountState> emit,
  ) async {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }
}
