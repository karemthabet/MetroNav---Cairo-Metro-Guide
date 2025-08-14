// station.dart

class Station {
  final String name;       // اسم المحطة
  final int lineNumber;    // رقم خط المترو
  final double latitude;   // خط العرض
  final double longitude;  // خط الطول
  final int? branch;       // رقم الفرع (اختياري)

  const Station({
    required this.name,
    required this.lineNumber,
    required this.latitude,
    required this.longitude,
    this.branch,
  });

  // لتحويل بيانات من Map لـ Station
  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      name: map['name'] as String,
      lineNumber: map['lineNumber'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      branch: map['branch'] as int?,
    );
  }

  // لتحويل Station لـ Map (ممكن نستخدمها للتخزين أو الإرسال)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lineNumber': lineNumber,
      'latitude': latitude,
      'longitude': longitude,
      'branch': branch,
    };
  }
}
