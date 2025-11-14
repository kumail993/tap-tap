import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/products/models/product_model.dart';

class ReviewTile extends StatelessWidget {
  final ReviewModel r;
  const ReviewTile(this.r, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.08),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < r.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
              horizontalSpace(10),
              CustomText(
                title: '${r.rating}/5',
                fontSize: 12,
                color: Colors.white70,
              ),
            ],
          ),

          verticalSpace(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: r.reviewerName,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              CustomText(
                title: _formatDate(r.date),
                fontSize: 12,
                color: Colors.white54,
              ),
            ],
          ),

          verticalSpace(6),

          Text(
            r.reviewerEmail,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),

          verticalSpace(10),

          Text(r.comment, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    final d = DateTime.tryParse(date);
    if (d == null) return date;
    return "${d.day}/${d.month}/${d.year}";
  }
}
