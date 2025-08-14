class RouteResult {
  final String start;
  final String end;
  final List<String> pathStations;
  final int stopsCount;
  final int minutes;
  final int ticketPrice;

  RouteResult({
    required this.start,
    required this.end,
    required this.pathStations,
    required this.stopsCount,
    required this.minutes,
    required this.ticketPrice,
  });
}