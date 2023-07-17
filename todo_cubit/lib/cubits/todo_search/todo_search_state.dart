part of 'todo_search_cubit.dart';

class TodoSearchState extends Equatable {
  final String keyword;
  const TodoSearchState(this.keyword);

  factory TodoSearchState.initial() {
    return const TodoSearchState('');
  }

  @override
  List<Object> get props => [keyword];

  TodoSearchState copyWith({String? keyword}) {
    return TodoSearchState(keyword ?? this.keyword);
  }
}
