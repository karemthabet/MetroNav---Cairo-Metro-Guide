import 'package:url_launcher/url_launcher.dart';

enum TravelMode { walking, driving, transit }

class MapsService {
  static Future<void> openDirections({
    required String origin,
    required String destination,
    TravelMode mode = TravelMode.transit,
  }) async {
    final modeStr = _getTravelModeString(mode);

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=${Uri.encodeComponent(origin)}'
      '&destination=${Uri.encodeComponent(destination)}'
      '&travelmode=$modeStr',
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'تعذر فتح تطبيق الخرائط';
    }
  }

  static String _getTravelModeString(TravelMode mode) {
    return mode == TravelMode.walking
        ? 'walking'
        : mode == TravelMode.driving
        ? 'driving'
        : 'transit';
  }

  static Future<void> fromCurrentToStation(
    String destination, {
    TravelMode mode = TravelMode.transit,
  }) async {
    await openDirections(
      origin: 'current+location',
      destination: destination,
      mode: mode,
    );
  }

  static Future<void> stationToStation(
    String start,
    String end, {
    TravelMode mode = TravelMode.transit,
  }) async {
    await openDirections(origin: start, destination: end, mode: mode);
  }
}
