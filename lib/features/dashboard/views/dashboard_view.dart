import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomText(title: 'Dashboard')),
    );
  }
}
