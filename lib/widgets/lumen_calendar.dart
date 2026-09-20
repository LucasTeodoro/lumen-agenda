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
            _NavButton(icon: Icons.chevron_left, onTap: onPreviousMonth),
            Expanded(
              child: Text(
                monthLabel[0].toUpperCase() + monthLabel.substring(1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: LumenColors.text,
                ),
              ),
            ),
            _NavButton(icon: Icons.chevron_right, onTap: onNextMonth),
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
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
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
    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LumenTheme.radius),
          side: const BorderSide(color: LumenColors.border),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(LumenTheme.radius),
          child: Icon(icon, size: 18, color: LumenColors.text),
        ),
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
        borderRadius: BorderRadius.circular(LumenTheme.radius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(LumenTheme.radius),
            color: selected
                ? LumenColors.primary
                : today
                    ? LumenColors.accent
                    : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$day',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: selected ? LumenColors.primaryForeground : LumenColors.text,
                ),
              ),
              if (hasTasks)
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? LumenColors.primaryForeground : LumenColors.muted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
