import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_listener/enums/todo_tab_filter.dart';

part 'todo_tab_state.dart';

class TodoTabCubit extends Cubit<TodoTabState> {
  TodoTabCubit() : super(TodoTabState.initial());

  void changeTodoTab(TodoTab tab) {
    emit(state.copyWith(tab: tab));
  }
}
