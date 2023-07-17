import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_search_state.dart';

class TodoSearchCubit extends Cubit<TodoSearchState> {
  TodoSearchCubit() : super(const TodoSearchState(''));

  void onSearchValueChange(String keyword) {
    emit(state.copyWith(keyword: keyword));
  }
}
