import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/list/list_cubit.dart';
import 'package:todo_cubit/models/todo.dart';

class TodoListItem extends StatefulWidget {
  final ToDoObject todo;

  const TodoListItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (() {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              controller.text = widget.todo.description;
              return StatefulBuilder(
                  builder: ((context, setState) => AlertDialog(
                        title: const Text("Edit Todo"),
                        content: TextField(
                          controller: controller,
                          autofocus: true,
                          decoration: InputDecoration(
                            errorText: _error ? "Value cannot be empty" : null,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _error = controller.text.isEmpty;
                                  if (!_error) {
                                    context.read<ListCubit>().editTodo(
                                        widget.todo.identifier,
                                        controller.text);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              child: const Text("Edit")),
                        ],
                      )));
            });
      }),
      leading: Checkbox(
          value: widget.todo.isCompleted,
          onChanged: (bool? isChecked) {
            context.read<ListCubit>().toggleTodoStatus(widget.todo.identifier);
          }),
      title: Text(widget.todo.description),
    );
  }
}
