import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/enums/todo_tab_filter.dart';

part 'todo_tab_filter_state.dart';

class TodoTabFilterCubit extends Cubit<TodoTabFilterState> {
  TodoTabFilterCubit() : super(TodoTabFilterState.initial());

  void changeTodoTab(TodoTabFilter tab) {
    emit(state.copyWith(todoTabFilter: tab));
  }
}
