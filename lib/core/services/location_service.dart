import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:metro_app/features/planning/data/station.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("خدمة تحديد الموقع غير مفعلة");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("تم رفض إذن الوصول للموقع");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("إذن الموقع مرفوض بشكل دائم");
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; 
    double dLat = _deg2rad(lat2 - lat1);
    double dLon = _deg2rad(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static double _deg2rad(double deg) => deg * (pi / 180);

  static Future<Map<String, dynamic>> getNearestStation(List<Station> stations) async {
    Position position = await getCurrentLocation();
    Station? nearest;
    double minDistance = double.infinity;

    for (var station in stations) {
      double dist = calculateDistance(
        position.latitude,
        position.longitude,
        station.latitude,
        station.longitude,
      );
      if (dist < minDistance) {
        minDistance = dist;
        nearest = station;
      }
    }

    return {
      "station": nearest,
      "distance": minDistance,
    };
  }
}
