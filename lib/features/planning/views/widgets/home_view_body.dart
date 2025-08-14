import 'package:flutter/material.dart';
import 'package:metro_app/core/services/location_service.dart';
import 'package:metro_app/core/services/maps_service.dart';
import 'package:metro_app/core/utils/assets/app_assets.dart';
import 'package:metro_app/features/planning/data/station_coordinates.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? nearestStationName;
  double? nearestDistance;
  var nearestStation;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadNearestStation();
  }

  Future<void> _loadNearestStation() async {
    try {
      var result = await LocationService.getNearestStation(stationsCoordinates);
      setState(() {
        nearestStation = result["station"];
        nearestStationName = nearestStation?.name;
        nearestDistance = result["distance"];
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: size.height * .06),
          Image.asset(AppAssets.logo, width: 120),
          const SizedBox(height: 20),

          loading
              ? const CircularProgressIndicator()
              : nearestStationName == null
                  ? const Text("لا توجد محطة قريبة")
                  : Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          "أقرب محطة: $nearestStationName",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "المسافة: ${nearestDistance!.toStringAsFixed(2)} كم",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.map, color: Colors.blue),
                          onPressed: () =>
                              MapsService.navigateToStation(nearestStation),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
