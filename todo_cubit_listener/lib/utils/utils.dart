import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_listener/cubits/todo_list/todo_list_cubit.dart';

class Utils {
  static getActiveTodoCound(BuildContext context) {
    return context
        .read<TodoListCubit>()
        .state
        .todos
        .where((e) => !e.isCompleted)
        .length;
  }
}
