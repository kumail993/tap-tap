import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/models/product_model.dart';

class GlassProductCard extends StatelessWidget {
  final ProductModel product;

  const GlassProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: Image.network(
                      product.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              verticalSpace(12),

              // TITLE
              CustomText(
                title: product.title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),

              verticalSpace(6),

              // CATEGORY
              CustomText(
                title: product.category,
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.7),
              ),

              verticalSpace(10),

              // PRICE
              Row(
                children: [
                  CustomText(
                    title: "\$${product.price}",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),

                  const Spacer(),

                  // STOCK BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: product.stock > 0
                          ? Colors.green.withValues(alpha: 0.25)
                          : Colors.red.withValues(alpha: 0.25),
                      border: Border.all(
                        color: product.stock > 0
                            ? Colors.greenAccent.withValues(alpha: 0.4)
                            : Colors.redAccent.withValues(alpha: 0.4),
                      ),
                    ),
                    child: CustomText(
                      title: product.stock > 0 ? "In Stock" : "Out of Stock",
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
