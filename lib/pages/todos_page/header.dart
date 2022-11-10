import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/active_count/active_count_cubit.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "TODO",
          style: TextStyle(fontSize: 40.0),
        ),
        BlocBuilder<ActiveCountCubit, ActiveCountState>(
          builder: (context, state) {
            return Text(
              "${state.count} item" + (state.count != 1 ? "s" : ""),
              style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
            );
          },
        ),
        // Text(
        //   "${context.watch<ActiveCountCubit>().state.count} ${context.watch<ActiveCountCubit>().state.count > 1 ? "items" : "item"}",
        //   style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
        // ),
      ],
    );
  }
}
