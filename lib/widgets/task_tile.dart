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
    final done = task.done;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        color: done ? const Color(0x66101820) : LumenColors.card,
        borderColor: done ? const Color(0x33FFFFFF) : LumenColors.teal.withValues(alpha: 0.55),
        padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? LumenColors.muted : LumenColors.teal,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    done ? 'Concluída' : 'Pendente',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: done ? LumenColors.muted : LumenColors.teal,
                    ),
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: done ? FontWeight.w400 : FontWeight.w600,
                      color: done ? LumenColors.muted : LumenColors.text,
                      decoration: done ? TextDecoration.lineThrough : null,
                      decorationColor: LumenColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: done ? 'Desfazer' : 'Fiz essa tarefa',
              onPressed: onToggle,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                done ? Icons.undo_rounded : Icons.check_circle_outline_rounded,
                size: 22,
                color: done ? LumenColors.muted : LumenColors.teal,
              ),
            ),
            IconButton(
              tooltip: 'Excluir',
              onPressed: onRemove,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 22,
                color: LumenColors.pink.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
