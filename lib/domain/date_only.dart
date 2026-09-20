DateTime dateOnly(DateTime day) => DateTime(day.year, day.month, day.day);

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
