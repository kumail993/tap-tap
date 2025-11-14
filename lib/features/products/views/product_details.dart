import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/models/product_model.dart';
import 'package:tap_task/features/products/widgets/description_section.dart';
import 'package:tap_task/features/products/widgets/hero_image.dart';
import 'package:tap_task/features/products/widgets/product_info_card.dart';
import 'package:tap_task/features/products/widgets/review_section.dart';
import 'package:tap_task/features/products/widgets/thumbnail_crousel.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.17,
              child: Image.network(product.thumbnail, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF020617)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: isMobile
                          ? _buildMobileLayout()
                          : _buildDesktopLayout(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              HeroImage(product.thumbnail),
              verticalSpace(20),
              ThumbnailCarousel(product.images),
              verticalSpace(30),
              DescriptionSection(product),
              verticalSpace(40),
              ReviewsSection(product.reviews),
            ],
          ),
        ),

        horizontalSpace(40),
        Expanded(flex: 2, child: ProductInfoCard(product)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        HeroImage(product.thumbnail),
        verticalSpace(15),
        ThumbnailCarousel(product.images),
        verticalSpace(20),
        ProductInfoCard(product),
        verticalSpace(25),
        DescriptionSection(product),
        verticalSpace(40),
        ReviewsSection(product.reviews),
      ],
    );
  }
}
