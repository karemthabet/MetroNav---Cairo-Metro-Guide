// show_view.dart
import 'package:flutter/material.dart';
import 'package:metro_app/features/planning/data/model/route_result.dart';

class ShowView extends StatelessWidget {
  final RouteResult result;
  const ShowView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الرحلة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('من:', result.start),
            _buildInfoRow('إلى:', result.end),
            _buildInfoRow('عدد المحطات:', '${result.stopsCount}'),
            _buildInfoRow('الوقت المتوقع:', '${result.minutes} دقيقة'),
            _buildInfoRow('سعر التذكرة:', '${result.ticketPrice} جنيه'),
            const SizedBox(height: 24),
            const Text(
              'مسار الرحلة:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: result.pathStations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(
                      result.pathStations[index],
                      textAlign: TextAlign.right,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}