import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int activeTodoQuantity;

  ActiveTodoCountCubit(this.activeTodoQuantity)
      : super(ActiveTodoCountState(activeTodoQuantity));

  void updateActiveTodoCount(int count) {
    emit(state.copyWith(activeTodoCount: count));
  }
}
