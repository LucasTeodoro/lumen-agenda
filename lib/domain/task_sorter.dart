import '../models/task_item.dart';

List<TaskItem> sortTasks(List<TaskItem> tasks) {
  final copy = [...tasks];
  copy.sort((a, b) {
    if (a.done != b.done) {
      return a.done ? 1 : -1;
    }
    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  });
  return copy;
}
