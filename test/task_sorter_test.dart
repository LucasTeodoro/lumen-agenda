import 'package:flutter_test/flutter_test.dart';
import 'package:lumen_agenda/domain/task_sorter.dart';
import 'package:lumen_agenda/models/task_item.dart';

TaskItem _task(String title, {bool done = false}) {
  return TaskItem(
    id: title,
    title: title,
    day: DateTime(2026, 9, 20),
    done: done,
  );
}

void main() {
  test('lista vazia permanece vazia', () {
    expect(sortTasks(const []), isEmpty);
  });

  test('pendente vem antes de concluida mesmo se o titulo for depois no alfabeto', () {
    final sorted = sortTasks([
      _task('Abc', done: true),
      _task('Zebra'),
    ]);

    expect(sorted.map((t) => t.title), ['Zebra', 'Abc']);
  });

  test('pendentes ficam em ordem alfabetica ignorando maiusculas', () {
    final sorted = sortTasks([
      _task('Beta'),
      _task('alfa'),
    ]);

    expect(sorted.map((t) => t.title), ['alfa', 'Beta']);
  });

  test('concluidas ficam em ordem alfabetica ignorando maiusculas', () {
    final sorted = sortTasks([
      _task('Mango', done: true),
      _task('abacate', done: true),
    ]);

    expect(sorted.map((t) => t.title), ['abacate', 'Mango']);
  });

  test('mistura: pendentes A-Z e depois concluidas A-Z', () {
    final sorted = sortTasks([
      _task('Zebra'),
      _task('Abc', done: true),
      _task('beta'),
    ]);

    expect(sorted.map((t) => t.title), ['beta', 'Zebra', 'Abc']);
  });

  test('nao altera a lista original', () {
    final original = [_task('B'), _task('A')];
    sortTasks(original);
    expect(original.map((t) => t.title), ['B', 'A']);
  });
}
