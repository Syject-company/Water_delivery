class Period {
  const Period({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.available,
  });

  final String id;
  final int startTime;
  final int endTime;
  final bool available;
}
