import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/dashboard/widgets/charts_row.dart';
import 'package:tap_task/features/dashboard/widgets/header.dart';
import 'package:tap_task/features/dashboard/widgets/metric_cards_row.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 880;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DashboardHeader(),
                      verticalSpace(30),
                      MetricCardsRow(),
                      verticalSpace(30),
                      ChartsRow(isMobile: isMobile),
                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
