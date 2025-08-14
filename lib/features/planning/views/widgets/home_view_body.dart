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
        _showSnack('أقرب محطة: $nearest');
      } else {
        _showSnack('لا يمكن تحديد المحطة الأقرب حالياً');
      }
    } catch (e) {
      _showSnack(e.toString());
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
        setState(() {
          selectedEndStation = nearest;
        });
        _showSnack('أقرب محطة مترو للعنوان المدخل: $nearest');
      } else {
        _showSnack('لا توجد محطة مترو قريبة من العنوان المدخل');
      }
    } catch (e) {
      _showSnack('حدث خطأ أثناء البحث: ${e.toString()}');
    } finally {
      setState(() => isSearchingAddress = false);
    }
  }

  Future<void> _openMapToNearest() async {
    final station = nearestStationName ?? selectedStartStation;
    if (station == null) {
      _showSnack('لم يتم تحديد محطة');
      return;
    }

    try {
      await MapsService.fromCurrentToStation(station);
    } catch (e) {
      _showSnack('تعذر فتح الخرائط: $e');
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
      );
    } catch (e) {
      _showSnack('تعذر فتح الخرائط: $e');
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
    final Size size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(
          bottom: bottomPadding + 16,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              const SizedBox(height: 20),
              Image.asset(AppAssets.logo, width: size.width * 0.3),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomDropDown(
                      label: 'محطة البداية',
                      value: selectedStartStation,
                      onChanged:
                          (v) => setState(() => selectedStartStation = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _openMapToNearest,
                    icon: const Icon(Icons.near_me,color: Colors.white,),
                    tooltip: 'أقرب محطة',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomDropDown(
                label: 'محطة الوصول',
                value: selectedEndStation,
                onChanged: (v) => setState(() => selectedEndStation = v),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      color: Colors.blue,
                      widthButton: 75,
                      text: 'خريطة المسار',
                      icon: Icons.map,
                      onTap: _openMapBetweenStations,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      widthButton: 75,
                      color: Colors.blue,
                      text: 'عرض التفاصيل',
                      icon: Icons.directions,
                      onTap: _showRouteResult,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AddressTextField(
                textController: addressController,
                label: 'أدخل العنوان المطلوب الوصول إليه',
              ),
              const SizedBox(height: 8),
              isSearchingAddress
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _findNearestStationToAddress,
                    child: const Text('ابحث عن أقرب محطة لهذا العنوان'),
                  ),
              const SizedBox(height: 8),
              const Text(
                'سيتم تحديد أقرب محطة مترو للعنوان المدخل تلقائياً',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: bottomPadding > 0 ? bottomPadding : 16,
              ),
            ],
          ),
        ),
      );
    
  }
}
