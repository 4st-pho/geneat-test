import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_cubit/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/cubits/todo_list_filter/todo_list_filter_cubit.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit/cubits/todo_tab_filter/todo_tab_filter_cubit.dart';
import 'package:todo_cubit/pages/todo_page/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoListCubit(), lazy: false),
        BlocProvider(create: (context) => TodoSearchCubit(), lazy: false),
        BlocProvider(create: (context) => TodoTabFilterCubit(), lazy: false),
        BlocProvider(
          create: (context) => ActiveTodoCountCubit(
            context.read<TodoListCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => TodoListFilterCubit(
            todoListCubit: context.read<TodoListCubit>(),
            todoSearchCubit: context.read<TodoSearchCubit>(),
            todoTabFilterCubit: context.read<TodoTabFilterCubit>(),
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const TodoPage(),
        ),
      ),
    );
  }
}
