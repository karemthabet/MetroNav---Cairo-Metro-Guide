import 'package:flutter/material.dart';
import 'package:metro_app/core/functions/hide_status_bar.dart';
import 'package:metro_app/metro_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  hideStatusBar();
  runApp(const MetroApp());
}
