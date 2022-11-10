import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/pages/todos_page/todos_page.dart';
import 'cubits/cubits.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilterCubit>(create: (context) => FilterCubit()),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
        BlocProvider<ListCubit>(create: (context) => ListCubit()),
        BlocProvider<ActiveCountCubit>(
            create: (context) => ActiveCountCubit(
                initalActiveTodoCount:
                    context.read<ListCubit>().state.todos.length,
                listCubit: BlocProvider.of<ListCubit>(context))),
        BlocProvider<FilteredListCubit>(
            create: (context) => FilteredListCubit(
                initalTodos: context.read<ListCubit>().state.todos,
                filterCubit: BlocProvider.of<FilterCubit>(context),
                listCubit: BlocProvider.of<ListCubit>(context),
                searchCubit: BlocProvider.of<SearchCubit>(context)))
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
