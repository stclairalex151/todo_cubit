part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final Filter filter;

  const FilterState({
    required this.filter,
  });

  factory FilterState.inital() {
    return const FilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  FilterState copyWith({
    Filter? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  String toString() => 'FilterState(filter: $filter)';
}
