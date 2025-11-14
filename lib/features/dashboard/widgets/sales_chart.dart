import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:tap_task/core/imports/common_imports.dart';

class GlassSalesChart extends StatelessWidget {
  const GlassSalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final spots = [
      const FlSpot(0, 30),
      const FlSpot(1, 45),
      const FlSpot(2, 35),
      const FlSpot(3, 60),
      const FlSpot(4, 70),
      const FlSpot(5, 68),
      const FlSpot(6, 90),
    ];

    return _glassCard(
      title: "Weekly Sales Trend",
      subtitle: "Units sold in the last 7 days",
      height: 260,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 100,

          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const labels = [
                    "Mon",
                    "Tue",
                    "Wed",
                    "Thu",
                    "Fri",
                    "Sat",
                    "Sun",
                  ];
                  if (value < 0 || value > 6) return const SizedBox();
                  return Text(
                    labels[value.toInt()],
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  );
                },
              ),
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 3,
              color: Colors.cyanAccent,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent.withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard({
    required String title,
    required String subtitle,
    required double height,
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: height + 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.14),
                Colors.white.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              verticalSpace(16),

              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
