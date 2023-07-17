import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<TodoSeachValueChanged>(_onSearchValueChange,
        transformer: debounce(const Duration(milliseconds: 1000)));
  }
  EventTransformer<Event> debounce<Event>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).asyncExpand(mapper);
  }

  Future<void> _onSearchValueChange(
    TodoSeachValueChanged event,
    Emitter<TodoSearchState> emit,
  ) async {
    emit(state.copyWith(keyword: event.keyword));
  }
}
