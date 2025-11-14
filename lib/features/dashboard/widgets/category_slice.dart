import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/dashboard/models/category_slice_model.dart';

class GlassCategoryChart extends StatelessWidget {
  const GlassCategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      CategorySlice("Electronics", 42, Colors.cyanAccent),
      CategorySlice("Fashion", 26, Colors.amberAccent),
      CategorySlice("Kitchen", 18, Colors.greenAccent),
      CategorySlice("Sports", 14, Colors.pinkAccent),
    ];

    final total = data.fold(0.0, (sum, e) => sum + e.value);

    return _glassCard(
      title: "Category Distribution",
      subtitle: "Product categories share",
      height: 260,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40,
                sectionsSpace: 2,
                sections: data
                    .map(
                      (e) => PieChartSectionData(
                        value: e.value,
                        color: e.color,
                        radius: 60,
                        title:
                            "${((e.value / total) * 100).toStringAsFixed(0)}%",
                        titleStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: e.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Text(
                          e.label,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      Text(
                        "${e.value.toInt()}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
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
