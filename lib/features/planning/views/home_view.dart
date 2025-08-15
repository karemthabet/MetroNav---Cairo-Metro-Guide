import 'package:flutter/material.dart';
import 'package:metro_app/core/utils/colors/app_colors.dart';
import 'package:metro_app/features/planning/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: HomeViewBody(),
    );
  }
}
