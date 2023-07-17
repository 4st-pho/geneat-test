import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_bloc/blocs/todo_list_filter/todo_list_filter_bloc.dart';
import 'package:todo_bloc/constant/app_string.dart';
import 'package:todo_bloc/pages/todo_page/widgets/todo_item.dart';

class TodoListFilter extends StatefulWidget {
  const TodoListFilter({super.key});

  @override
  State<TodoListFilter> createState() => _TodoListFilterState();
}

class _TodoListFilterState extends State<TodoListFilter> {
  late final TextEditingController _editTodoContenController;
  @override
  void initState() {
    super.initState();
    _editTodoContenController = TextEditingController();
  }

  @override
  void dispose() {
    _editTodoContenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListFilterBloc, TodoListFilterState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: state.todos.length,
          itemBuilder: (BuildContext context, int index) {
            final todo = state.todos[index];
            return Dismissible(
              key: ValueKey<String>(todo.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(10),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => context
                  .read<TodoListBloc>()
                  .add(TodoListItemRemoved(id: todo.id)),
              confirmDismiss: (_) async {
                return _showConfirmDismissDialog(context);
              },
              child: TodoItem(
                todo: todo,
                controller: _editTodoContenController,
              ),
            );
          },
        );
      },
    );
  }

  Future<bool?> _showConfirmDismissDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppString.areYouSure),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppString.cancel),
          ),
          const SizedBox(width: 40),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppString.ok),
          ),
        ],
      ),
    );
  }
}
