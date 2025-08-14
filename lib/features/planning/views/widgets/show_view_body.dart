import 'package:flutter/material.dart';
import 'package:metro_app/features/planning/data/model/route_result.dart';
import 'package:metro_app/features/planning/views/widgets/build_info_row.dart';

class ShowViewBody extends StatelessWidget {
  const ShowViewBody({super.key, required this.result});
  final RouteResult result;


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildInfoRow('محطة الانطلاق:', result.start),
                    const Divider(height: 20),
                    buildInfoRow('محطة الوصول:', result.end),
                    const Divider(height: 20),
                    buildInfoRow('عدد المحطات:', '${result.stopsCount}'),
                    const Divider(height: 20),
                    buildInfoRow('الوقت المتوقع:', '${result.minutes} دقيقة'),
                    const Divider(height: 20),
                    buildInfoRow('سعر التذكرة:', '${result.ticketPrice} جنيه'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'مسار الرحلة:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  fontFamily: 'Tajawal',
                ),
                textAlign: TextAlign.right,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // قائمة المحطات
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: result.pathStations.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      title: Text(
                        result.pathStations[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Tajawal',
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: Icon(
                        Icons.directions_transit,
                        color: Colors.blue.shade600,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
   
  }
}