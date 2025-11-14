import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/models/product_model.dart';

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
              _HeroImage(product.thumbnail),
              verticalSpace(20),
              _ThumbnailCarousel(product.images),
              verticalSpace(30),
              _DescriptionSection(product),
              verticalSpace(40),
              _ReviewsSection(product.reviews),
            ],
          ),
        ),

        horizontalSpace(40),
        Expanded(flex: 2, child: _ProductInfoCard(product)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _HeroImage(product.thumbnail),
        verticalSpace(15),
        _ThumbnailCarousel(product.images),
        verticalSpace(20),
        _ProductInfoCard(product),
        verticalSpace(25),
        _DescriptionSection(product),
        verticalSpace(40),
        _ReviewsSection(product.reviews),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  final String url;
  const _HeroImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 520,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _ThumbnailCarousel extends StatelessWidget {
  final List<String> images;
  const _ThumbnailCarousel(this.images);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[i]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProductInfoCard extends StatelessWidget {
  final ProductModel product;
  const _ProductInfoCard(this.product);

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
                  Text(
                    "${product.rating} / 5",
                    style: const TextStyle(color: Colors.white70),
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
              Text(
                product.warrantyInformation,
                style: const TextStyle(color: Colors.white70),
              ),

              verticalSpace(15),

              const _InfoTile(label: "Shipping"),
              Text(
                product.shippingInformation,
                style: const TextStyle(color: Colors.white70),
              ),

              verticalSpace(15),

              const _InfoTile(label: "Return Policy"),
              Text(
                product.returnPolicy,
                style: const TextStyle(color: Colors.white70),
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

class _DescriptionSection extends StatelessWidget {
  final ProductModel product;
  const _DescriptionSection(this.product);

  @override
  Widget build(BuildContext context) {
    return _glassSection(
      title: "Description",
      child: Text(
        product.description,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  final List<ReviewModel> reviews;
  const _ReviewsSection(this.reviews);

  @override
  Widget build(BuildContext context) {
    return _glassSection(
      title: "Customer Reviews",
      child: Column(children: reviews.map((r) => _ReviewTile(r)).toList()),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final ReviewModel r;
  const _ReviewTile(this.r);

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
              Text(
                "${r.rating}/5",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
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
              Text(
                _formatDate(r.date),
                style: TextStyle(color: Colors.white54, fontSize: 12),
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
