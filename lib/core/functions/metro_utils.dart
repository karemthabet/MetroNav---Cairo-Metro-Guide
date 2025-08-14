import 'package:metro_app/core/utils/constants/app_constants.dart';
import 'package:metro_app/features/planning/data/model/route_result.dart';

class MetroUtils {
  static int? lineOf(String station) {
    if (AppConstants.cairoMetroLine1.contains(station)) return 1;
    if (AppConstants.cairoMetroLine2.contains(station)) return 2;
    if (AppConstants.cairoMetroLine3.contains(station)) return 3;
    return null;
  }

  static List<String>? lineList(int lineNo) {
    switch (lineNo) {
      case 1: return AppConstants.cairoMetroLine1;
      case 2: return AppConstants.cairoMetroLine2;
      case 3: return AppConstants.cairoMetroLine3;
      default: return null;
    }
  }

  static List<String> _buildSameLinePath(List<String> line, String start, String end) {
    final i1 = line.indexOf(start);
    final i2 = line.indexOf(end);
    if (i1 == -1 || i2 == -1) return [];
    return i1 <= i2 
        ? line.sublist(i1, i2 + 1) 
        : line.sublist(i2, i1 + 1).reversed.toList();
  }

  static Set<String> _interchangesBetween(int lineA, int lineB) {
    final a = lineList(lineA) ?? [];
    final b = lineList(lineB) ?? [];
    return a.toSet().intersection(b.toSet());
  }

  static RouteResult? computeRoute(String start, String end) {
    if (start == end) {
      return RouteResult(
        start: start,
        end: end,
        pathStations: [start],
        stopsCount: 0,
        minutes: 0,
        ticketPrice: AppConstants.ticketPriceForStops(0),
      );
    }

    final l1 = lineOf(start);
    final l2 = lineOf(end);
    if (l1 == null || l2 == null) return null;

    // Same line route
    if (l1 == l2) {
      final line = lineList(l1)!;
      final path = _buildSameLinePath(line, start, end);
      if (path.isEmpty) return null;
      
      final stops = path.length - 1;
      return RouteResult(
        start: start,
        end: end,
        pathStations: path,
        stopsCount: stops,
        minutes: stops * AppConstants.minutesPerStop,
        ticketPrice: AppConstants.ticketPriceForStops(stops),
      );
    }

    // Different lines - find best interchange
    final interchanges = _interchangesBetween(l1, l2);
    if (interchanges.isEmpty) return null;

    RouteResult? bestRoute;
    for (final interchange in interchanges) {
      final firstLeg = _buildSameLinePath(lineList(l1)!, start, interchange);
      final secondLeg = _buildSameLinePath(lineList(l2)!, interchange, end);
      
      if (firstLeg.isNotEmpty && secondLeg.isNotEmpty) {
        final fullPath = [...firstLeg, ...secondLeg.skip(1)];
        final stops = fullPath.length - 1;
        final currentRoute = RouteResult(
          start: start,
          end: end,
          pathStations: fullPath,
          stopsCount: stops,
          minutes: stops * AppConstants.minutesPerStop,
          ticketPrice: AppConstants.ticketPriceForStops(stops),
        );

        if (bestRoute == null || stops < bestRoute.stopsCount) {
          bestRoute = currentRoute;
        }
      }
    }

    return bestRoute;
  }
}