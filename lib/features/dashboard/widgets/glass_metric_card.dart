import 'dart:ui';
import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/dashboard/models/metric_cards_model.dart';

class GlassMetricCard extends StatelessWidget {
  final MetricCardData metric;

  const GlassMetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.14),
                  Colors.white.withValues(alpha: 0.05),
                ],
              ),
            ),

            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: metric.color.withValues(alpha: 0.15),
                  ),
                  child: Icon(metric.icon, color: metric.color, size: 22),
                ),
                horizontalSpace(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: metric.title,
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                      verticalSpace(2),
                      CustomText(
                        title: metric.value,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      verticalSpace(2),
                      Text(
                        metric.sub,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
