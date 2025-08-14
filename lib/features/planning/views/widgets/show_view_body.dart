import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';
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
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor.withValues(alpha: 0.9),
            AppColors.backgroundColor.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 6,
            color: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.blue.shade800.withValues(alpha: 0.6),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  buildInfoRow(' :محطة الانطلاق', result.start),
                  const Divider(color: Colors.blueGrey, height: 25),
                  buildInfoRow(' :محطة الوصول', result.end),
                  const Divider(color: Colors.blueGrey, height: 25),
                  buildInfoRow(' :عدد المحطات', '${result.stopsCount}'),
                  const Divider(color: Colors.blueGrey, height: 25),
                  buildInfoRow(' :الوقت المتوقع', '${result.minutes} دقيقة'),
                  const Divider(color: Colors.blueGrey, height: 25),
                  buildInfoRow(' :سعر التذكرة', '${result.ticketPrice} جنيه'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              ':مسار الرحلة',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade300,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.right,
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: Card(
              elevation: 6,
              color: AppColors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Colors.blue.shade800.withValues(alpha: 0.6),

                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  itemCount: result.pathStations.length,
                  separatorBuilder:
                      (_, __) => Divider(
                        color: Colors.blueGrey.withValues(alpha: .5),
                        height: 1,
                        indent: 70,
                        endIndent: 20,
                      ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade900.withValues(
                          alpha: 0.8,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        result.pathStations[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Tajawal',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: Icon(
                        Icons.directions_transit,
                        color: Colors.blue.shade400,
                        size: 28,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
