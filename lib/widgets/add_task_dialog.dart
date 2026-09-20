import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/task_store.dart';
import '../theme/lumen_theme.dart';
import 'lumen_button.dart';

Future<void> showAddTaskDialog(BuildContext context, DateTime day) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AddTaskDialog(day: day),
  );
}

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key, required this.day});

  final DateTime day;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _controller.text.trim();
    if (title.isEmpty) {
      setState(() => _error = 'Escreva o nome da tarefa.');
      return;
    }
    await context.read<TaskStore>().add(title, widget.day);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: LumenColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LumenTheme.cardRadius),
        side: const BorderSide(color: LumenColors.border),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nova tarefa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: LumenColors.text,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Entra como pendente. Você marca depois, se quiser.',
              style: TextStyle(color: LumenColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            const Text(
              'Título',
              style: TextStyle(
                color: LumenColors.text,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: 'Ex.: revisar calendário',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 16),
            LumenButton(label: 'Adicionar à lista', onPressed: _submit),
            const SizedBox(height: 8),
            LumenButton(
              label: 'Cancelar',
              variant: LumenButtonVariant.outline,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
