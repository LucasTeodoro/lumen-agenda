import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../theme/lumen_theme.dart';
import 'glass_card.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onRemove,
  });

  final TaskItem task;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: task.done ? 0.62 : 1,
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Semantics(
                button: true,
                label: task.done
                    ? 'Desmarcar ${task.title}'
                    : 'Concluir ${task.title}',
                child: InkWell(
                  onTap: onToggle,
                  customBorder: const CircleBorder(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: task.done
                          ? const LinearGradient(
                              colors: [LumenColors.teal, LumenColors.violet],
                            )
                          : null,
                      border: Border.all(
                        color: task.done ? Colors.transparent : LumenColors.teal,
                        width: 2,
                      ),
                    ),
                    child: task.done
                        ? const Icon(Icons.check, size: 16, color: Color(0xFF07101C))
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: LumenColors.text,
                    decoration: task.done ? TextDecoration.lineThrough : null,
                    decorationColor: LumenColors.muted,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Remover tarefa',
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, color: LumenColors.pink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
