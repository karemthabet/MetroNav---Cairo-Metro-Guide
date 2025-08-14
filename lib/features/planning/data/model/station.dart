class Station {
  final String name;
  final int lineNumber;
  final double latitude;
  final double longitude;
  final int branch;

  const Station({
    required this.name,
    required this.lineNumber,
    required this.latitude,
    required this.longitude,
    this.branch = 0,
  });
}

const List<Station> stationsCoordinates = [
  // Line 1 Stations
  Station(name: 'المنيب', lineNumber: 1, latitude: 29.981153, longitude: 31.212324),
  Station(name: 'ساقية مكي', lineNumber: 1, latitude: 29.996838, longitude: 31.209687),
  Station(name: 'أم المصريين', lineNumber: 1, latitude: 30.006991, longitude: 31.208721),
  Station(name: 'الجيزة', lineNumber: 1, latitude: 30.012268, longitude: 31.210523),
  Station(name: 'فيصل', lineNumber: 1, latitude: 30.018734, longitude: 31.206060),
  Station(name: 'جامعة القاهرة', lineNumber: 1, latitude: 30.027726, longitude: 31.201682),
  Station(name: 'البحوث', lineNumber: 1, latitude: 30.035756, longitude: 31.200237),
  Station(name: 'الدقي', lineNumber: 1, latitude: 30.038580, longitude: 31.212382),
  Station(name: 'الأوبرا', lineNumber: 1, latitude: 30.041930, longitude: 31.224967),
  Station(name: 'السادات', lineNumber: 1, latitude: 30.044135, longitude: 31.234325),
  Station(name: 'محمد نجيب', lineNumber: 1, latitude: 30.045332, longitude: 31.243876),
  Station(name: 'العتبة', lineNumber: 1, latitude: 30.052354, longitude: 31.246746),
  Station(name: 'الشهداء', lineNumber: 1, latitude: 30.061121, longitude: 31.246012),
  Station(name: 'غمرة', lineNumber: 1, latitude: 30.069050, longitude: 31.264539),
  Station(name: 'الدمرداش', lineNumber: 1, latitude: 30.077323, longitude: 31.277756),
  Station(name: 'منشية الصدر', lineNumber: 1, latitude: 30.082005, longitude: 31.287443),
  Station(name: 'كوبري القبة', lineNumber: 1, latitude: 30.087178, longitude: 31.294048),
  Station(name: 'حمامات القبة', lineNumber: 1, latitude: 30.091237, longitude: 31.298785),
  Station(name: 'حدائق الزيتون', lineNumber: 1, latitude: 30.105906, longitude: 31.310373),
  Station(name: 'حلمية الزيتون', lineNumber: 1, latitude: 30.113255, longitude: 31.313958),
  Station(name: 'المطرية', lineNumber: 1, latitude: 30.121345, longitude: 31.313651),
  Station(name: 'عين شمس', lineNumber: 1, latitude: 30.131027, longitude: 31.319019),
  Station(name: 'عزبة النخل', lineNumber: 1, latitude: 30.139308, longitude: 31.324256),
  Station(name: 'المرج', lineNumber: 1, latitude: 30.152079, longitude: 31.335608),
  Station(name: 'المرج الجديدة', lineNumber: 1, latitude: 30.163647, longitude: 31.338452),

  // Line 2 Stations
  Station(name: 'شبرا الخيمة', lineNumber: 2, latitude: 30.129400, longitude: 31.242000),
  Station(name: 'كلية الزراعة', lineNumber: 2, latitude: 30.122433, longitude: 31.244417),
  Station(name: 'المظلات', lineNumber: 2, latitude: 30.113702, longitude: 31.248612),
  Station(name: 'الخلفاوي', lineNumber: 2, latitude: 30.104209, longitude: 31.245715),
  Station(name: 'سانت تريزا', lineNumber: 2, latitude: 30.097880, longitude: 31.245357),
  Station(name: 'روض الفرج', lineNumber: 2, latitude: 30.087954, longitude: 31.245403),
  Station(name: 'المسرة', lineNumber: 2, latitude: 30.080601, longitude: 31.245324),
  Station(name: 'الشهداء', lineNumber: 2, latitude: 30.061121, longitude: 31.246012),
  Station(name: 'العتبة', lineNumber: 2, latitude: 30.052354, longitude: 31.246746),
  Station(name: 'محمد نجيب', lineNumber: 2, latitude: 30.045332, longitude: 31.243876),
  Station(name: 'السادات', lineNumber: 2, latitude: 30.044135, longitude: 31.234325),
  Station(name: 'الأوبرا', lineNumber: 2, latitude: 30.041930, longitude: 31.224967),
  Station(name: 'الدقي', lineNumber: 2, latitude: 30.038580, longitude: 31.212382),
  Station(name: 'البحوث', lineNumber: 2, latitude: 30.035756, longitude: 31.200237),
  Station(name: 'فيصل', lineNumber: 2, latitude: 30.018734, longitude: 31.206060),
  Station(name: 'جامعة القاهرة', lineNumber: 2, latitude: 30.027726, longitude: 31.201682),
  Station(name: 'المنيب', lineNumber: 2, latitude: 29.981153, longitude: 31.212324),

  // Line 3 Stations
  Station(name: 'عدلي منصور', lineNumber: 3, latitude: 30.146440, longitude: 31.421889),
  Station(name: 'الهايكستب', lineNumber: 3, latitude: 30.143874, longitude: 31.404603),
  Station(name: 'عمر بن الخطاب', lineNumber: 3, latitude: 30.140344, longitude: 31.394119),
  Station(name: 'قباء', lineNumber: 3, latitude: 30.134912, longitude: 31.383910),
  Station(name: 'هشام بركات', lineNumber: 3, latitude: 30.130841, longitude: 31.372627),
  Station(name: 'النزهة', lineNumber: 3, latitude: 30.127988, longitude: 31.359986),
  Station(name: 'نادي الشمس', lineNumber: 3, latitude: 30.125516, longitude: 31.348766),
  Station(name: 'ألف مسكن', lineNumber: 3, latitude: 30.119021, longitude: 31.340046),
  Station(name: 'هليوبوليس', lineNumber: 3, latitude: 30.108427, longitude: 31.338210),
  Station(name: 'هارون', lineNumber: 3, latitude: 30.101380, longitude: 31.332826),
  Station(name: 'الأهرام', lineNumber: 3, latitude: 30.091720, longitude: 31.326247),
  Station(name: 'كلية البنات', lineNumber: 3, latitude: 30.084017, longitude: 31.328917),
  Station(name: 'الإستاد', lineNumber: 3, latitude: 30.072918, longitude: 31.316891),
  Station(name: 'أرض المعارض', lineNumber: 3, latitude: 30.073261, longitude: 31.300721),
  Station(name: 'العباسية', lineNumber: 3, latitude: 30.071969, longitude: 31.283263),
  Station(name: 'عبده باشا', lineNumber: 3, latitude: 30.064800, longitude: 31.274638),
  Station(name: 'العتبة', lineNumber: 3, latitude: 30.052354, longitude: 31.246746),
  Station(name: 'باب الشعرية', lineNumber: 3, latitude: 30.054163, longitude: 31.255704),
  Station(name: 'الجيش', lineNumber: 3, latitude: 30.061761, longitude: 31.266749),
  Station(name: 'محمد نجيب', lineNumber: 3, latitude: 30.045332, longitude: 31.243876),
  Station(name: 'ماسبيرو', lineNumber: 3, latitude: 30.055743, longitude: 31.231919),
  Station(name: 'السفارات', lineNumber: 3, latitude: 30.058000, longitude: 31.225000),
  Station(name: 'الكيلو 4.5', lineNumber: 3, latitude: 30.080000, longitude: 31.210000),
  Station(name: 'النهضة', lineNumber: 3, latitude: 30.090000, longitude: 31.200000),
];