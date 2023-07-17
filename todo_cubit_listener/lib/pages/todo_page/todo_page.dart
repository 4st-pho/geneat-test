import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_listener/constant/app_string.dart';
import 'package:todo_cubit_listener/constant/app_text_style.dart';
import 'package:todo_cubit_listener/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_cubit_listener/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit_listener/cubits/todo_list_filter/todo_list_filter_cubit.dart';
import 'package:todo_cubit_listener/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit_listener/cubits/todo_tab/todo_tab_cubit.dart';
import 'package:todo_cubit_listener/enums/todo_tab_filter.dart';
import 'package:todo_cubit_listener/extensions/string_extension.dart';
import 'package:todo_cubit_listener/pages/todo_page/widgets/add_todo_text_filed.dart';
import 'package:todo_cubit_listener/pages/todo_page/widgets/todo_list_filter.dart';
import 'package:todo_cubit_listener/utils/debounce.dart';
import 'package:todo_cubit_listener/utils/utils.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final debounce = Debounce();
  void updateFilterTodoList() {
    context.read<TodoListFilterCubit>().updateFilterTodoList(
          todos: context.read<TodoListCubit>().state.todos,
          todoTab: context.read<TodoTabCubit>().state.tab,
          searchKeyword: context.read<TodoSearchCubit>().state.keyword,
        );
  }

  void updateActiveTodoCount() {
    final activeTodoCount = Utils.getActiveTodoCound(context);
    context.read<ActiveTodoCountCubit>().updateActiveTodoCount(activeTodoCount);
  }

  @override
  void dispose() {
    debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoSearchCubit, TodoSearchState>(
            listener: (context, state) => updateFilterTodoList()),
        BlocListener<TodoTabCubit, TodoTabState>(
            listener: (context, state) => updateFilterTodoList()),
        BlocListener<TodoListCubit, TodoListState>(listener: (context, state) {
          updateFilterTodoList();
          updateActiveTodoCount();
        }),
      ],
      child: Scaffold(
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
      ),
    );
  }

  Widget _buildFilterTabButton() {
    return BlocBuilder<TodoTabCubit, TodoTabState>(
      builder: (context, state) {
        return Row(
          children: TodoTab.values
              .map(
                (tab) => Expanded(
                  child: TextButton(
                    onPressed: () =>
                        context.read<TodoTabCubit>().changeTodoTab(tab),
                    child: Text(
                      tab.name.capitalize(),
                      style: tab == state.tab
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
