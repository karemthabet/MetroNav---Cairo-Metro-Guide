// maps_service.dart
import 'package:url_launcher/url_launcher.dart';

class MapsService {
  static Future<void> openDirections({
    required String origin,
    required String destination,
  }) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=${Uri.encodeComponent(origin)}'
      '&destination=${Uri.encodeComponent(destination)}'
      '&travelmode=transit',
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch Google Maps';
    }
  }

  static Future<void> fromCurrentToStation(String destination) async {
    await openDirections(origin: 'My Location', destination: destination);
  }

  static Future<void> stationToStation(String start, String end) async {
    await openDirections(origin: start, destination: end);
  }
}