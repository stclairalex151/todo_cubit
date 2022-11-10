import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit/cubits/filter/filter_cubit.dart';
import 'package:todo_cubit/cubits/list/list_cubit.dart';
import 'package:todo_cubit/cubits/search/search_cubit.dart';
import 'package:todo_cubit/models/filter.dart';
import 'package:todo_cubit/models/todo.dart';

part 'filtered_list_state.dart';

class FilteredListCubit extends Cubit<FilteredListState> {
  final FilterCubit filterCubit;
  final ListCubit listCubit;
  final SearchCubit searchCubit;

  final List<ToDoObject> initalTodos;

  late StreamSubscription filterSubscription;
  late StreamSubscription listSubscription;
  late StreamSubscription searchSubscription;

  FilteredListCubit({
    required this.initalTodos,
    required this.filterCubit,
    required this.listCubit,
    required this.searchCubit,
  }) : super(FilteredListState(filteredList: initalTodos)) {
    filterSubscription = filterCubit.stream.listen((FilterState filterState) {
      setFilteredList();
    });

    searchSubscription = searchCubit.stream.listen((SearchState searchState) {
      setFilteredList();
    });

    listSubscription = listCubit.stream.listen((ListState listState) {
      setFilteredList();
    });
  }

  void setFilteredList() {
    List<ToDoObject> filteredList;

    switch (filterCubit.state.filter) {
      case Filter.all:
        filteredList = listCubit.state.todos;
        break;
      case Filter.active:
        filteredList = listCubit.state.todos
            .where((ToDoObject object) => object.isCompleted == false)
            .toList();
        break;
      case Filter.completed:
        filteredList = listCubit.state.todos
            .where((ToDoObject object) => object.isCompleted == true)
            .toList();
        break;
    }

    if (searchCubit.state.searchTerm.isNotEmpty) {
      filteredList = filteredList
          .where((ToDoObject object) => object.description
              .toLowerCase()
              .contains(searchCubit.state.searchTerm.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(filteredList: filteredList));
  }

  @override
  Future<void> close() {
    listSubscription.cancel();
    filterSubscription.cancel();
    searchSubscription.cancel();
    return super.close();
  }
}
