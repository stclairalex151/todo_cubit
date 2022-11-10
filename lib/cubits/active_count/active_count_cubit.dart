import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit/cubits/list/list_cubit.dart';

part 'active_count_state.dart';

class ActiveCountCubit extends Cubit<ActiveCountState> {
  final ListCubit listCubit;
  final int initalActiveTodoCount;
  late final StreamSubscription listSubscription;

  ActiveCountCubit({
    required this.initalActiveTodoCount,
    required this.listCubit,
  }) : super(ActiveCountState(count: initalActiveTodoCount)) {
    listSubscription = listCubit.stream.listen((ListState listState) {
      final int currentCount = listState.todos
          .where((element) => element.isCompleted == false)
          .toList()
          .length;

      emit(state.copyWith(count: currentCount));
    });
  }

  @override
  Future<void> close() {
    listSubscription.cancel();
    return super.close();
  }
}
