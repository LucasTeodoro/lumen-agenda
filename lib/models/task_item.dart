class TaskItem {
  const TaskItem({
    required this.id,
    required this.title,
    required this.day,
    this.done = false,
  });

  final String id;
  final String title;
  final DateTime day;
  final bool done;

  TaskItem copyWith({bool? done}) {
    return TaskItem(
      id: id,
      title: title,
      day: day,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'day': DateTime(day.year, day.month, day.day).toIso8601String(),
      'done': done,
    };
  }

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    final parsed = DateTime.parse(json['day'] as String);
    return TaskItem(
      id: json['id'] as String,
      title: json['title'] as String,
      day: DateTime(parsed.year, parsed.month, parsed.day),
      done: json['done'] as bool,
    );
  }
}
