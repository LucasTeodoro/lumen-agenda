import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task_item.dart';
import '../state/task_store.dart';
import '../theme/lumen_theme.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/aurora_backdrop.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key, required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TaskStore>();
    final tasks = store.tasksOn(day);
    final pending = tasks.where((task) => !task.done).toList();
    final done = tasks.where((task) => task.done).toList();
    final heading = DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(day);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddTaskDialog(context, day),
        backgroundColor: LumenColors.teal,
        foregroundColor: const Color(0xFF07101C),
        icon: const Icon(Icons.add),
        label: const Text('Nova tarefa'),
      ),
      body: AuroraBackdrop(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 20, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_rounded, color: LumenColors.text),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            heading[0].toUpperCase() + heading.substring(1),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: LumenColors.text,
                            ),
                          ),
                          Text(
                            '${pending.length} pendente(s) · ${done.length} concluída(s)',
                            style: const TextStyle(color: LumenColors.muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: tasks.isEmpty
                    ? const _EmptyTasks()
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                        children: [
                          if (pending.isNotEmpty) ...[
                            const _SectionTitle(label: 'Pendentes'),
                            ...pending.map((task) => _tile(context, task)),
                          ],
                          if (done.isNotEmpty) ...[
                            const _SectionTitle(label: 'Concluídas'),
                            ...done.map((task) => _tile(context, task)),
                          ],
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, TaskItem task) {
    final store = context.read<TaskStore>();
    return TaskTile(
      task: task,
      onToggle: () => store.toggle(task.id),
      onRemove: () => store.remove(task.id),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: LumenColors.teal,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('✦', style: TextStyle(fontSize: 42, color: LumenColors.violet)),
            SizedBox(height: 8),
            Text(
              'Nenhuma tarefa neste dia.',
              style: TextStyle(
                color: LumenColors.text,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Toque em Nova tarefa para acender a lista.',
              textAlign: TextAlign.center,
              style: TextStyle(color: LumenColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
