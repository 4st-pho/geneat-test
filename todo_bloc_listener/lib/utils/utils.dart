import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_listener/blocs/blocs.dart';

class Utils {
  static getActiveTodoCound(BuildContext context) {
    return context
        .read<TodoListBloc>()
        .state
        .todos
        .where((e) => !e.isCompleted)
        .length;
  }
}
