import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/date_only.dart';
import '../theme/lumen_theme.dart';

class LumenCalendar extends StatelessWidget {
  const LumenCalendar({
    super.key,
    required this.visibleMonth,
    required this.selectedDay,
    required this.daysWithTasks,
    required this.onSelectDay,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  final DateTime visibleMonth;
  final DateTime selectedDay;
  final Set<DateTime> daysWithTasks;
  final ValueChanged<DateTime> onSelectDay;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  static const _weekdays = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final first = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final daysInMonth = DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day;
    final leading = first.weekday % 7;
    final cells = leading + daysInMonth;
    final trailing = (7 - (cells % 7)) % 7;
    final total = cells + trailing;
    final monthLabel = DateFormat('MMMM yyyy', 'pt_BR').format(first);

    return Column(
      children: [
        Row(
          children: [
            _NavButton(icon: Icons.chevron_left_rounded, onTap: onPreviousMonth),
            Expanded(
              child: Text(
                monthLabel[0].toUpperCase() + monthLabel.substring(1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: LumenColors.text,
                ),
              ),
            ),
            _NavButton(icon: Icons.chevron_right_rounded, onTap: onNextMonth),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final label in _weekdays)
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: LumenColors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: total,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            final dayNumber = index - leading + 1;
            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return const SizedBox.shrink();
            }
            final day = DateTime(visibleMonth.year, visibleMonth.month, dayNumber);
            final selected = isSameDay(day, selectedDay);
            final today = isSameDay(day, DateTime.now());
            final hasTasks = daysWithTasks.any((item) => isSameDay(item, day));
            return _DayCell(
              day: dayNumber,
              selected: selected,
              today: today,
              hasTasks: hasTasks,
              onTap: () => onSelectDay(day),
            );
          },
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: LumenColors.text),
      style: IconButton.styleFrom(
        backgroundColor: LumenColors.glass,
        shape: const CircleBorder(),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.selected,
    required this.today,
    required this.hasTasks,
    required this.onTap,
  });

  final int day;
  final bool selected;
  final bool today;
  final bool hasTasks;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Dia $day',
      selected: selected,
      child: InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: selected
              ? const LinearGradient(
                  colors: [LumenColors.teal, LumenColors.violet],
                )
              : null,
          border: today && !selected
              ? Border.all(color: LumenColors.pink.withValues(alpha: 0.8))
              : null,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: LumenColors.teal.withValues(alpha: 0.45),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected ? const Color(0xFF07101C) : LumenColors.text,
              ),
            ),
            if (hasTasks)
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? const Color(0xFF07101C) : LumenColors.pink,
                ),
              ),
          ],
        ),
      ),
    ),
    );
  }
}
