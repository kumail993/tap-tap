import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/dashboard/widgets/category_slice.dart';
import 'package:tap_task/features/dashboard/widgets/sales_chart.dart';

class ChartsRow extends StatelessWidget {
  final bool isMobile;

  const ChartsRow({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: const [
          GlassSalesChart(),
          SizedBox(height: 22),
          GlassCategoryChart(),
        ],
      );
    }

    return Row(
      children: const [
        Expanded(child: GlassSalesChart()),
        SizedBox(width: 22),
        Expanded(child: GlassCategoryChart()),
      ],
    );
  }
}
