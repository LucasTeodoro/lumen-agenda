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
      padding: const EdgeInsets.only(bottom: 8),
      child: Opacity(
        opacity: task.done ? 0.7 : 1,
        child: GlassCard(
          padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
          child: Row(
            children: [
              Semantics(
                button: true,
                label: task.done
                    ? 'Desmarcar ${task.title}'
                    : 'Concluir ${task.title}',
                child: InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: task.done ? LumenColors.primary : Colors.transparent,
                      border: Border.all(
                        color: task.done ? LumenColors.primary : LumenColors.muted,
                      ),
                    ),
                    child: task.done
                        ? const Icon(
                            Icons.check,
                            size: 12,
                            color: LumenColors.primaryForeground,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: LumenColors.text,
                    decoration: task.done ? TextDecoration.lineThrough : null,
                    decorationColor: LumenColors.muted,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Remover tarefa',
                onPressed: onRemove,
                icon: const Icon(Icons.close, size: 16, color: LumenColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
