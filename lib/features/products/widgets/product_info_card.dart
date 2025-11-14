import 'dart:ui';

import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/products/models/product_model.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductModel product;
  const ProductInfoCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.12),
                Colors.white.withValues(alpha: 0.05),
              ],
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: product.title,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),

              verticalSpace(8),
              Text(
                "${product.brand} • ${product.category}",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              verticalSpace(25),

              CustomText(
                title: "\$${product.price.toStringAsFixed(2)}",
                fontSize: 34,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w700,
              ),

              if (product.discountPercentage > 0)
                Text(
                  "${product.discountPercentage}% OFF",
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              verticalSpace(20),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber.shade400),
                  horizontalSpace(5),
                  CustomText(
                    title: '${product.rating} / 5',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  horizontalSpace(15),
                  Text(
                    product.stock > 0 ? "In Stock" : "Out of Stock",
                    style: TextStyle(
                      color: product.stock > 0
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                ],
              ),
              verticalSpace(30),
              const _InfoTile(label: "Warranty"),
              CustomText(
                title: product.warrantyInformation,
                fontSize: 14,
                color: Colors.white70,
              ),

              verticalSpace(15),
              const _InfoTile(label: "Shipping"),
              CustomText(
                title: product.shippingInformation,
                fontSize: 14,
                color: Colors.white70,
              ),

              verticalSpace(15),
              const _InfoTile(label: "Return Policy"),
              CustomText(
                title: product.returnPolicy,
                fontSize: 14,
                color: Colors.white70,
              ),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  const _InfoTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: label,
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }
}
