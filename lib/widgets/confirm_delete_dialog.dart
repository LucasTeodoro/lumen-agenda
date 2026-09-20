import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';
import 'lumen_button.dart';

Future<bool> confirmDeleteTask(BuildContext context, String title) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: const Color(0xF10E1530),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LumenTheme.cardRadius),
          side: const BorderSide(color: LumenColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Excluir tarefa?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: LumenColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tem certeza que quer excluir "$title"? Essa ação não tem volta.',
                style: const TextStyle(color: LumenColors.muted, fontSize: 14),
              ),
              const SizedBox(height: 20),
              LumenButton(
                label: 'Excluir',
                variant: LumenButtonVariant.destructive,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
              const SizedBox(height: 8),
              LumenButton(
                label: 'Cancelar',
                variant: LumenButtonVariant.outline,
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
            ],
          ),
        ),
      );
    },
  );
  return confirmed == true;
}
