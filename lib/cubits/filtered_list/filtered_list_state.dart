// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_list_cubit.dart';

class FilteredListState extends Equatable {
  final List<ToDoObject> filteredList;

  const FilteredListState({
    required this.filteredList,
  });

  factory FilteredListState.initial() {
    return const FilteredListState(filteredList: []);
  }

  @override
  List<Object?> get props => [filteredList];

  @override
  bool get stringify => true;

  FilteredListState copyWith({
    List<ToDoObject>? filteredList,
  }) {
    return FilteredListState(
      filteredList: filteredList ?? this.filteredList,
    );
  }
}
