part of 'list_cubit.dart';

class ListState extends Equatable {
  final List<ToDoObject> todos;

  const ListState({
    required this.todos,
  });

  factory ListState.inital() {
    return const ListState(todos: []);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'ListState(todos: $todos)';

  ListState copyWith({
    List<ToDoObject>? todos,
  }) {
    return ListState(
      todos: todos ?? this.todos,
    );
  }
}
