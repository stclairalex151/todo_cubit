part of 'active_count_cubit.dart';

class ActiveCountState extends Equatable {
  final int count;

  const ActiveCountState({
    required this.count,
  });

  factory ActiveCountState.inital() {
    return const ActiveCountState(count: 0);
  }

  ActiveCountState copyWith({
    int? count,
  }) {
    return ActiveCountState(
      count: count ?? this.count,
    );
  }

  @override
  String toString() => 'ActiveCountState(count: $count)';

  @override
  List<Object?> get props => [count];
}
