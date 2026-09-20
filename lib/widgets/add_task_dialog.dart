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
      backgroundColor: const Color(0xF10B1026),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: LumenColors.glassBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nova tarefa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: LumenColors.text,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Ela entra como pendente e você marca depois, se quiser.',
              style: TextStyle(color: LumenColors.muted),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: 'Título',
                hintText: 'Ex.: revisar calendário',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 18),
            LumenButton(label: 'Adicionar à lista', onPressed: _submit),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Center(
                child: Text('Cancelar', style: TextStyle(color: LumenColors.muted)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
