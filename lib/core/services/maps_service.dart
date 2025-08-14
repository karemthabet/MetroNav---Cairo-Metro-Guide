import 'package:url_launcher/url_launcher.dart';
import 'package:metro_app/features/planning/data/station.dart';

class MapsService {
  static Future<void> navigateToStation(Station station) async {
    final url =
        "https://www.google.com/maps/dir/?api=1&destination=${station.latitude},${station.longitude}&travelmode=driving";
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception("لا يمكن فتح خرائط جوجل");
    }
  }
}
