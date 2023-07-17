import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/constant/app_string.dart';
import 'package:todo_cubit/constant/app_text_style.dart';
import 'package:todo_cubit/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit/cubits/todo_tab_filter/todo_tab_filter_cubit.dart';
import 'package:todo_cubit/enums/todo_tab_filter.dart';
import 'package:todo_cubit/extensions/string_extension.dart';
import 'package:todo_cubit/pages/todo_page/widgets/add_todo_text_filed.dart';
import 'package:todo_cubit/pages/todo_page/widgets/todo_list_filter.dart';
import 'package:todo_cubit/utils/debounce.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final debounce = Debounce();

  @override
  void dispose() {
    debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        children: [
          _buildTodoHeader(),
          const AddTodoTextField(),
          const SizedBox(height: 20),
          _buildSearchBar(),
          _buildFilterTabButton(),
          const TodoListFilter(),
        ],
      ),
    );
  }

  Widget _buildFilterTabButton() {
    return BlocBuilder<TodoTabFilterCubit, TodoTabFilterState>(
      builder: (context, state) {
        return Row(
          children: TodoTabFilter.values
              .map(
                (tab) => Expanded(
                  child: TextButton(
                    onPressed: () =>
                        context.read<TodoTabFilterCubit>().changeTodoTab(tab),
                    child: Text(
                      tab.name.capitalize(),
                      style: tab == state.todoTabFilter
                          ? AppTextStyle.blue18px
                          : AppTextStyle.grey18px,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildTodoHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(AppString.todo, style: AppTextStyle.black40px),
            Expanded(
              child: BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
                builder: (context, state) {
                  final activeTodoCount = state.activeTodoCount;
                  return Text(
                    activeTodoCount <= 1
                        ? '$activeTodoCount item left'
                        : '$activeTodoCount items left',
                    style: AppTextStyle.redAccent20px,
                    textAlign: TextAlign.right,
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: const Icon(Icons.search),
        hintText: AppString.searchTodos,
        border: InputBorder.none,
      ),
      onChanged: (value) => debounce.run(() {
        context.read<TodoSearchCubit>().onSearchValueChange(value);
      }),
    );
  }
}
