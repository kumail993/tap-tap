import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/dashboard/models/metric_cards_model.dart';
import 'package:tap_task/features/dashboard/widgets/glass_metric_card.dart';

class MetricCardsRow extends StatelessWidget {
  MetricCardsRow({super.key});

  final metrics = [
    MetricCardData(
      title: "Total Products",
      value: "248",
      sub: "+12 this week",
      icon: Icons.inventory_2_rounded,
      color: Colors.cyanAccent,
    ),
    MetricCardData(
      title: "In Stock",
      value: "196",
      sub: "82% availability",
      icon: Icons.check_circle_rounded,
      color: Colors.greenAccent,
    ),
    MetricCardData(
      title: "Out of Stock",
      value: "52",
      sub: "Reorder suggested",
      icon: Icons.warning_rounded,
      color: Colors.amberAccent,
    ),
    MetricCardData(
      title: "Avg. Price",
      value: "\$74.20",
      sub: "+5.2% vs last month",
      icon: Icons.attach_money_rounded,
      color: Colors.pinkAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      spacing: 20,
      children: [...metrics.map((m) => GlassMetricCard(metric: m))],
    );
  }
}
