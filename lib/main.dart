import 'package:flutter/material.dart';
import 'package:tap_task/app/app.dart';
import 'package:tap_task/config/supabase/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  runApp(const MyApp());
}
