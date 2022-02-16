extension DateHelper on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool get isTomorrow {
    final now = DateTime.now().add(Duration(days: 1));
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }
}
