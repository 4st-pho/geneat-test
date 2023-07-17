import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/constant/app_string.dart';
import 'package:todo_cubit/constant/app_text_style.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';

class AddTodoTextField extends StatefulWidget {
  const AddTodoTextField({super.key});

  @override
  State<AddTodoTextField> createState() => _AddTodoTextFieldState();
}

class _AddTodoTextFieldState extends State<AddTodoTextField> {
  late final TextEditingController _addTodoController;

  @override
  void initState() {
    super.initState();
    _addTodoController = TextEditingController();
  }

  @override
  void dispose() {
    _addTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _addTodoController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: AppString.whatToDo,
        hintStyle: AppTextStyle.grey20px,
      ),
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          context.read<TodoListCubit>().addTodo(value);
        }
        _addTodoController.clear();
      },
    );
  }
}
