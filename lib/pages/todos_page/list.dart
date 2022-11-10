import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';
import 'package:todo_cubit/cubits/filtered_list/filtered_list_cubit.dart';
import 'package:todo_cubit/models/todo.dart';
import 'package:todo_cubit/pages/todos_page/item.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ToDoObject> todos =
        context.watch<FilteredListCubit>().state.filteredList;

    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: ((context, index) => Dismissible(
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              key: ValueKey(todos[index].identifier),
              child: TodoListItem(
                todo: todos[index],
              ),
              confirmDismiss: ((_) {
                return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: ((context) {
                      return AlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text(
                            "Are you sure you want to delete this item?"),
                        actions: [
                          TextButton(
                              onPressed: (() => Navigator.pop(context, false)),
                              child: const Text("No")),
                          TextButton(
                              onPressed: (() => Navigator.pop(context, true)),
                              child: const Text("Yes"))
                        ],
                      );
                    }));
              }),
              onDismissed: (_) {
                context.read<ListCubit>().removeTodo(todos[index]);
              },
            )),
        separatorBuilder: ((context, index) => const Divider(
              color: Colors.grey,
            )),
        itemCount: todos.length);
  }
}
