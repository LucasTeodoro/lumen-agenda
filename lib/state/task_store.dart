import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../domain/date_only.dart';
import '../domain/task_sorter.dart';
import '../models/task_item.dart';
import '../storage/app_storage.dart';

class TaskStore extends ChangeNotifier {
  TaskStore(this._storage);

  static const _key = 'lumen.tasks';

  final AppStorage _storage;
  List<TaskItem> _tasks = [];

  Future<void> load() async {
    final raw = _storage.getString(_key);
    if (raw == null || raw.isEmpty) {
      _tasks = [];
      notifyListeners();
      return;
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    _tasks = decoded
        .map((item) => TaskItem.fromJson(item as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  List<TaskItem> tasksOn(DateTime day) {
    final filtered = _tasks.where((task) => isSameDay(task.day, day)).toList();
    return sortTasks(filtered);
  }

  Set<DateTime> daysWithTasks() {
    return {for (final task in _tasks) dateOnly(task.day)};
  }

  Future<void> add(String title, DateTime day) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _tasks = [
      ..._tasks,
      TaskItem(
        id: '${DateTime.now().microsecondsSinceEpoch}-${_tasks.length}',
        title: trimmed,
        day: dateOnly(day),
      ),
    ];
    await _persist();
  }

  Future<void> toggle(String id) async {
    _tasks = [
      for (final task in _tasks)
        if (task.id == id) task.copyWith(done: !task.done) else task,
    ];
    await _persist();
  }

  Future<void> remove(String id) async {
    _tasks = _tasks.where((task) => task.id != id).toList();
    await _persist();
  }

  Future<void> _persist() async {
    final encoded = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await _storage.setString(_key, encoded);
    notifyListeners();
  }
}
