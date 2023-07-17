import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_listener/blocs/blocs.dart';
import 'package:todo_bloc_listener/constant/app_string.dart';
import 'package:todo_bloc_listener/constant/app_text_style.dart';
import 'package:todo_bloc_listener/enums/todo_tab_filter.dart';
import 'package:todo_bloc_listener/extensions/string_extension.dart';
import 'package:todo_bloc_listener/pages/todo_page/widgets/add_todo_text_filed.dart';
import 'package:todo_bloc_listener/pages/todo_page/widgets/todo_list_filter.dart';
import 'package:todo_bloc_listener/utils/utils.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  void updateFilterTodoList() {
    context.read<TodoListFilterBloc>().add(
          TodoListFilterDependentChanged(
            todos: context.read<TodoListBloc>().state.todos,
            tab: context.read<TodoTabBloc>().state.tab,
            searchKeyword: context.read<TodoSearchBloc>().state.keyword,
          ),
        );
  }

  void updateActiveTodoCount() {
    final activeTodoCount = Utils.getActiveTodoCound(context);
    context
        .read<ActiveTodoCountBloc>()
        .add(ActiveTodoCountValueSet(activeTodoCount: activeTodoCount));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoSearchBloc, TodoSearchState>(
            listener: (context, state) => updateFilterTodoList()),
        BlocListener<TodoTabBloc, TodoTabState>(
            listener: (context, state) => updateFilterTodoList()),
        BlocListener<TodoListBloc, TodoListState>(listener: (context, state) {
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
    return BlocBuilder<TodoTabBloc, TodoTabState>(
      builder: (context, state) {
        return Row(
          children: TodoTab.values
              .map(
                (tab) => Expanded(
                  child: TextButton(
                    onPressed: () =>
                        context.read<TodoTabBloc>().add(TodoTabSeted(tab: tab)),
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
              child: BlocBuilder<ActiveTodoCountBloc, ActiveTodoCountState>(
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
        onChanged: (value) => context
            .read<TodoSearchBloc>()
            .add(TodoSeachValueChanged(keyword: value)));
  }
}
