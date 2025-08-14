import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_app/core/functions/metro_utils.dart';
import 'package:metro_app/core/services/location_service.dart';
import 'package:metro_app/core/services/maps_service.dart';
import 'package:metro_app/core/utils/assets/app_assets.dart';
import 'package:metro_app/core/utils/constants/app_constants.dart';
import 'package:metro_app/features/planning/data/model/station.dart';
import 'package:metro_app/features/planning/views/show_View.dart';
import 'package:metro_app/features/planning/views/widgets/address_text_field.dart';
import 'package:metro_app/features/planning/views/widgets/custom_button.dart';
import 'package:metro_app/features/planning/views/widgets/custom_drop_down.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? selectedStartStation;
  String? selectedEndStation;
  String? nearestStationName;
  final TextEditingController addressController = TextEditingController();
  bool isSearchingAddress = false;
  TravelMode selectedTravelMode = TravelMode.transit;

  @override
  void initState() {
    super.initState();
    _autoPickNearestStation();
  }

  Future<void> _autoPickNearestStation() async {
    try {
      final pos = await LocationService.determinePosition();
      final nearest = _findNearestStation(pos);
      if (nearest != null) {
        setState(() {
          nearestStationName = nearest;
          selectedStartStation = nearest;
        });
        _showSnack('تم تحديد أقرب محطة تلقائياً: $nearest');
      }
    } catch (e) {
      _showSnack('تعذر تحديد الموقع: ${e.toString()}');
    }
  }

  String? _findNearestStation(Position pos) {
    double? minDistance;
    String? nearestStation;

    for (final station in stationsCoordinates) {
      final distance = haversineKm(
        pos.latitude,
        pos.longitude,
        station.latitude,
        station.longitude,
      );

      if (minDistance == null || distance < minDistance) {
        minDistance = distance;
        nearestStation = station.name;
      }
    }

    return nearestStation;
  }

  Future<void> _findNearestStationToAddress() async {
    if (addressController.text.isEmpty) {
      _showSnack('الرجاء إدخال عنوان للبحث');
      return;
    }

    setState(() => isSearchingAddress = true);

    try {
      final locations = await locationFromAddress(addressController.text);

      if (locations.isEmpty) {
        _showSnack('لا يمكن العثور على العنوان المدخل');
        return;
      }

      final location = locations.first;
      final nearest = _findNearestStation(
        Position(
          latitude: location.latitude,
          longitude: location.longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        ),
      );

      if (nearest != null) {
        setState(() => selectedEndStation = nearest);
        _showSnack('تم تحديد أقرب محطة: $nearest');
      }
    } catch (e) {
      _showSnack('حدث خطأ أثناء البحث: ${e.toString()}');
    } finally {
      setState(() => isSearchingAddress = false);
    }
  }

  Future<void> _openMapToSelectedStation() async {
    final station = selectedStartStation;
    if (station == null) {
      _showSnack('لم يتم تحديد محطة بداية');
      return;
    }

    try {
      await MapsService.fromCurrentToStation(station, mode: selectedTravelMode);
    } catch (e) {
      _showSnack('تعذر فتح الخرائط: ${e.toString()}');
    }
  }

  Future<void> _openMapBetweenStations() async {
    if (selectedStartStation == null || selectedEndStation == null) {
      _showSnack('يجب تحديد محطتي البداية والنهاية');
      return;
    }

    try {
      await MapsService.stationToStation(
        selectedStartStation!,
        selectedEndStation!,
        mode: selectedTravelMode,
      );
    } catch (e) {
      _showSnack('تعذر فتح الخرائط: ${e.toString()}');
    }
  }

  void _showRouteResult() {
    if (selectedStartStation == null || selectedEndStation == null) {
      _showSnack('يجب تحديد محطتي البداية والنهاية');
      return;
    }

    final route = MetroUtils.computeRoute(
      selectedStartStation!,
      selectedEndStation!,
    );

    if (route == null) {
      _showSnack('لا يمكن حساب المسار بين المحطتين المحددتين');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ShowView(result: route)),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.right),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(bottom: bottomPadding + 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Image.asset(AppAssets.logo, width: size.width * 0.4),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                    label: 'محطة البداية',
                    value: selectedStartStation,
                    items:
                        AppConstants.allStationsUnique().map((station) {
                          return DropdownMenuItem(
                            value: station,
                            child: Text(
                              station,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (v) => setState(() => selectedStartStation = v),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade400],
                    ),
                  ),
                  child: IconButton(
                    onPressed: _openMapToSelectedStation,
                    icon: const Icon(Icons.near_me, color: Colors.white),
                    tooltip: 'فتح الخريطة من موقعك الحالي إلى المحطة',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomDropDown(
              label: 'محطة الوصول',
              value: selectedEndStation,
              items:
                  AppConstants.allStationsUnique().map((station) {
                    return DropdownMenuItem(
                      value: station,
                      child: Text(
                        station,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: (v) => setState(() => selectedEndStation = v),
            ),
            const SizedBox(height: 20),
            CustomDropDown<String>(
              label: 'وسيلة التنقل',
              value: _getTravelModeString(selectedTravelMode),
              items: [
                DropdownMenuItem(
                  value: 'مشي',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('مشي'),
                      SizedBox(width: 8),
                      Icon(
                        Icons.directions_walk,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'قيادة',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('قيادة'),
                      SizedBox(width: 8),
                      Icon(
                        Icons.directions_car,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'مواصلات',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('مواصلات'),
                      SizedBox(width: 8),
                      Icon(
                        Icons.directions_transit,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ],
              onChanged:
                  (mode) => setState(() {
                    selectedTravelMode =
                        mode == 'قيادة'
                            ? TravelMode.driving
                            : mode == 'مشي'
                            ? TravelMode.walking
                            : TravelMode.transit;
                  }),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    widthButton: 75,
                    color: Colors.blue.shade600,
                    text: 'خريطة المسار',
                    icon: Icons.map,
                    onTap: _openMapBetweenStations,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomButton(
                    widthButton: 75,
                    color: Colors.blue.shade600,
                    text: 'عرض التفاصيل',
                    icon: Icons.directions,
                    onTap: _showRouteResult,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            AddressTextField(
              textController: addressController,
              label: 'أدخل العنوان المطلوب الوصول إليه',
            ),
            const SizedBox(height: 15),
            isSearchingAddress
                ? const CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 2,
                )
                : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade400],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: _findNearestStationToAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'ابحث عن أقرب محطة لهذا العنوان',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            const SizedBox(height: 15),
            const Text(
              'سيتم تحديد أقرب محطة مترو للعنوان المدخل تلقائياً',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: bottomPadding > 0 ? bottomPadding : 20),
          ],
        ),
      ),
    );
  }
}

String _getTravelModeString(TravelMode mode) {
  return mode == TravelMode.walking
      ? 'مشي'
      : mode == TravelMode.driving
      ? 'قيادة'
      : 'مواصلات';
}
