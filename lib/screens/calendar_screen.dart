import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/date_only.dart';
import '../state/auth_store.dart';
import '../state/task_store.dart';
import '../theme/lumen_theme.dart';
import '../widgets/aurora_backdrop.dart';
import '../widgets/glass_card.dart';
import '../widgets/lumen_calendar.dart';
import 'task_list_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _visibleMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = dateOnly(now);
    _visibleMonth = DateTime(now.year, now.month);
  }

  void _openDay(DateTime day) {
    setState(() => _selectedDay = dateOnly(day));
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TaskListScreen(day: dateOnly(day)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AuthStore>().currentUser?.name ?? 'por aí';
    final marked = context.watch<TaskStore>().daysWithTasks();

    return Scaffold(
      body: AuroraBackdrop(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, $name',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                            color: LumenColors.text,
                          ),
                        ),
                        const Text(
                          'Toque um dia para abrir as tarefas.',
                          style: TextStyle(color: LumenColors.muted, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.read<AuthStore>().logout(),
                    child: const Text(
                      'Sair',
                      style: TextStyle(
                        color: LumenColors.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GlassCard(
                child: LumenCalendar(
                  visibleMonth: _visibleMonth,
                  selectedDay: _selectedDay,
                  daysWithTasks: marked,
                  onSelectDay: _openDay,
                  onPreviousMonth: () {
                    setState(() {
                      _visibleMonth = DateTime(
                        _visibleMonth.year,
                        _visibleMonth.month - 1,
                      );
                    });
                  },
                  onNextMonth: () {
                    setState(() {
                      _visibleMonth = DateTime(
                        _visibleMonth.year,
                        _visibleMonth.month + 1,
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Dias com ponto já têm tarefa.',
                style: TextStyle(color: LumenColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
