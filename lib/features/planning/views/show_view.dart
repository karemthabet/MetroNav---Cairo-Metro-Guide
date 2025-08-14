import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';
import 'package:metro_app/features/planning/data/model/route_result.dart';
import 'package:metro_app/features/planning/views/widgets/show_view_body.dart';

class ShowView extends StatelessWidget {
  final RouteResult result;
  const ShowView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,

        backgroundColor: AppColors.card,
        title: const Text(
          'تفاصيل الرحلة',
          style: TextStyle(fontFamily: 'Tajawal', color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ShowViewBody(result: result),
    );
  }
}
