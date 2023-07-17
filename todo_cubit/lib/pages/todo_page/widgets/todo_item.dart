import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_cubit/constant/app_string.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final TextEditingController controller;
  const TodoItem({
    Key? key,
    required this.todo,
    required this.controller,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (_) =>
            context.read<TodoListCubit>().toggleTodoStatus(widget.todo.id),
      ),
      title: Text(widget.todo.content),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            widget.controller.text = widget.todo.content;
            return _buildAlertDialog();
          },
        );
      },
    );
  }

  Widget _buildAlertDialog() {
    bool hasError = false;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return AlertDialog(
          title: const Text(AppString.editTodo),
          content: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              errorText: hasError ? 'invalid input' : null,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(AppString.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text(AppString.ok),
              onPressed: () {
                final currentText = widget.controller.text.trim();
                if (currentText.isEmpty) {
                  setState(() {
                    hasError = true;
                  });
                }
                if (!hasError) {
                  context
                      .read<TodoListCubit>()
                      .editTodo(widget.todo.id, currentText);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
