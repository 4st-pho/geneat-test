import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_listener/enums/todo_tab_filter.dart';

part 'todo_tab_event.dart';
part 'todo_tab_state.dart';

class TodoTabBloc extends Bloc<TodoTabEvent, TodoTabState> {
  TodoTabBloc() : super(TodoTabState.initial()) {
    on<TodoTabSeted>(_setTodoTab);
  }

  Future<void> _setTodoTab(
    TodoTabSeted event,
    Emitter<TodoTabState> emit,
  ) async {
    emit(state.copyWith(tab: event.tab));
  }
}
