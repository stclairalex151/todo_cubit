import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit/models/todo.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListState.inital());

  void addTodo(String description) {
    final newObject = ToDoObject(description: description);
    final newTodoList = [...state.todos, newObject];

    emit(state.copyWith(todos: newTodoList));
  }

  void editTodo(String id, String newDescription) {
    final newList = state.todos.map((ToDoObject object) {
      if (object.identifier == id) {
        return ToDoObject(
            id: id,
            description: newDescription,
            isCompleted: object.isCompleted);
      }
      return object;
    }).toList();

    emit(state.copyWith(todos: newList));
  }

  void toggleTodoStatus(String id) {
    final newList = state.todos.map((ToDoObject object) {
      if (object.identifier == id) {
        return ToDoObject(
            id: id,
            description: object.description,
            isCompleted: !(object.isCompleted));
      }
      return object;
    }).toList();

    emit(state.copyWith(todos: newList));
  }

  void removeTodo(ToDoObject object) {
    final newList = state.todos
        .where((element) => element.identifier != object.identifier)
        .toList();

    emit(state.copyWith(todos: newList));
  }
}
