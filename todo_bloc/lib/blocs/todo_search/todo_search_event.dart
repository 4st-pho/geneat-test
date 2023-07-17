part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class TodoSeachValueChanged extends TodoSearchEvent {
  final String keyword;
  const TodoSeachValueChanged({
    required this.keyword,
  });

  @override
  String toString() => 'SeachValueChanged(keyword: $keyword)';

  @override
  List<Object> get props => [keyword];
}
