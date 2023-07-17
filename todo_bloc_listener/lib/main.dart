import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc_listener/blocs/blocs.dart';
import 'package:todo_bloc_listener/pages/todo_page/todo_page.dart';
import 'package:todo_bloc_listener/utils/utils.dart';

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
        BlocProvider(create: (context) => TodoListBloc(), lazy: false),
        BlocProvider(create: (context) => TodoSearchBloc(), lazy: false),
        BlocProvider(create: (context) => TodoTabBloc(), lazy: false),
        BlocProvider(create: (context) {
          int activeTodoCount = Utils.getActiveTodoCound(context);
          return ActiveTodoCountBloc(activeTodoCount: activeTodoCount);
        }),
        BlocProvider(create: (context) {
          final allTodos = context.read<TodoListBloc>().state.todos;
          return TodoListFilterBloc(allTodos: allTodos);
        }),
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
