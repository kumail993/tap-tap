import 'dart:ui';

import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/products/models/product_model.dart';
import 'package:tap_task/features/products/widgets/review_tile.dart';

class ReviewsSection extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewsSection(this.reviews, {super.key});

  @override
  Widget build(BuildContext context) {
    return _glassSection(
      title: "Customer Reviews",
      child: Column(children: reviews.map((r) => ReviewTile(r)).toList()),
    );
  }

  Widget _glassSection({required String title, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.12),
                Colors.white.withValues(alpha: 0.04),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              verticalSpace(14),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
