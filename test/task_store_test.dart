import 'package:flutter_test/flutter_test.dart';
import 'package:lumen_agenda/state/task_store.dart';
import 'package:lumen_agenda/storage/app_storage.dart';

void main() {
  late MemoryAppStorage storage;
  late TaskStore store;
  final day = DateTime(2026, 9, 20);
  final otherDay = DateTime(2026, 9, 21);

  setUp(() {
    storage = MemoryAppStorage();
    store = TaskStore(storage);
  });

  test('tarefa nova nasce nao concluida', () async {
    await store.add('Estudar Flutter', day);

    expect(store.tasksOn(day).single.done, isFalse);
    expect(store.tasksOn(day).single.title, 'Estudar Flutter');
  });

  test('titulo vazio ou so espaco nao entra na lista', () async {
    await store.add('   ', day);
    await store.add('', day);

    expect(store.tasksOn(day), isEmpty);
  });

  test('tasksOn devolve so as tarefas do dia e ja ordenadas', () async {
    await store.add('Zebra', day);
    await store.add('Abc', otherDay);
    await store.add('beta', day);
    final first = store.tasksOn(day).first;
    await store.toggle(first.id);

    expect(store.tasksOn(day).map((t) => t.title), ['Zebra', 'beta']);
    expect(store.tasksOn(otherDay).map((t) => t.title), ['Abc']);
  });

  test('toggle marca e desmarca conclusao', () async {
    await store.add('Ler artigo', day);
    final id = store.tasksOn(day).single.id;

    await store.toggle(id);
    expect(store.tasksOn(day).single.done, isTrue);

    await store.toggle(id);
    expect(store.tasksOn(day).single.done, isFalse);
  });

  test('remove tira a tarefa da lista', () async {
    await store.add('Apagar isso', day);
    final id = store.tasksOn(day).single.id;

    await store.remove(id);

    expect(store.tasksOn(day), isEmpty);
  });

  test('daysWithTasks marca o dia que tem item', () async {
    await store.add('Prova', day);

    expect(store.daysWithTasks(), contains(DateTime(2026, 9, 20)));
    expect(store.daysWithTasks(), isNot(contains(DateTime(2026, 9, 21))));
  });

  test('persiste e recarrega do storage', () async {
    await store.add('Persistir', day);
    final reloaded = TaskStore(storage);
    await reloaded.load();

    expect(reloaded.tasksOn(day).single.title, 'Persistir');
  });
}
