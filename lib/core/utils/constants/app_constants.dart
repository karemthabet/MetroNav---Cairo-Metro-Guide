import 'dart:math';

import 'package:metro_app/features/planning/data/model/station.dart';

class AppConstants {
  static const int minutesPerStop = 2;

  static int ticketPriceForStops(int stops) {
    if (stops <= 9) return 7;
    if (stops <= 16) return 10;
    return 15;
  }

  static final List<String> cairoMetroLine1 = [
    "المنيب", "ساقية مكي", "أم المصريين", "الجيزة", "فيصل", 
    "جامعة القاهرة", "البحوث", "الدقي", "الأوبرا", "السادات",
    "محمد نجيب", "العتبة", "الشهداء", "غمرة", "الدمرداش",
    "منشية الصدر", "كوبري القبة", "حمامات القبة", "حدائق الزيتون",
    "حلمية الزيتون", "المطرية", "عين شمس", "عزبة النخل", "المرج",
    "المرج الجديدة"
  ];

  static final List<String> cairoMetroLine2 = [
    "شبرا الخيمة", "كلية الزراعة", "المظلات", "الخلفاوي", "سانت تريزا",
    "روض الفرج", "المسرة", "الشهداء", "العتبة", "محمد نجيب", "السادات",
    "الأوبرا", "الدقي", "البحوث", "فيصل", "جامعة القاهرة", "المنيب"
  ];

  static final List<String> cairoMetroLine3 = [
    "عدلي منصور", "الهايكستب", "عمر بن الخطاب", "قباء", "هشام بركات",
    "النزهة", "نادي الشمس", "ألف مسكن", "هليوبوليس", "هارون", "الأهرام",
    "كلية البنات", "الإستاد", "أرض المعارض", "العباسية", "عبده باشا",
    "العتبة", "باب الشعرية", "الجيش", "محمد نجيب", "ماسبيرو", "السفارات",
    "الكيلو 4.5", "النهضة"
  ];

  static List<String> allStationsUnique() {
    final set = {...cairoMetroLine1, ...cairoMetroLine2, ...cairoMetroLine3};
    return set.toList()..sort();
  }

  static Set<int> linesForStation(String station) {
    final s = <int>{};
    if (cairoMetroLine1.contains(station)) s.add(1);
    if (cairoMetroLine2.contains(station)) s.add(2);
    if (cairoMetroLine3.contains(station)) s.add(3);
    return s;
  }

  static Station? getStationByName(String name) {
    try {
      return stationsCoordinates.firstWhere((station) => station.name == name);
    } catch (e) {
      return null;
    }
  }
}

double haversineKm(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0;
  double dLat = _deg2rad(lat2 - lat1);
  double dLon = _deg2rad(lon2 - lon1);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _deg2rad(double deg) => deg * (pi / 180.0);