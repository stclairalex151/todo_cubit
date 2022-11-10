import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ToDoObject extends Equatable {
  final String identifier;
  final String description;
  final bool isCompleted;

  ToDoObject({String? id, required this.description, this.isCompleted = false})
      : identifier = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [identifier, description, isCompleted];

  @override
  String toString() =>
      'ToDoObject(identifier: $identifier, description: $description, isCompleted: $isCompleted)';
}
