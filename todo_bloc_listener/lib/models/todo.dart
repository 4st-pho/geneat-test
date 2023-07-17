import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  final String id;
  String content;
  bool isCompleted;
  Todo({
    String? id,
    required this.content,
    this.isCompleted = false,
  }) : id = id ?? uuid.v4();

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => id.hashCode ^ content.hashCode ^ isCompleted.hashCode;

  Todo copyWith({String? id, String? content, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      content: json['content'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
