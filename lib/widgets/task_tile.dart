import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../theme/lumen_theme.dart';
import 'glass_card.dart';
import 'lumen_button.dart';

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
        opacity: task.done ? 0.78 : 1,
        child: GlassCard(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: LumenColors.text,
                  decoration: task.done ? TextDecoration.lineThrough : null,
                  decorationColor: LumenColors.muted,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: LumenButton(
                      label: task.done ? 'Desfazer' : 'Fiz essa tarefa',
                      onPressed: onToggle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LumenButton(
                      label: 'Excluir',
                      variant: LumenButtonVariant.destructive,
                      onPressed: onRemove,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
