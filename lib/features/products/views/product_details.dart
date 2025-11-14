import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildWebLayout(context),
          );
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(product.thumbnail, fit: BoxFit.cover),
                ),
              ),
              verticalSpace(10),
              _buildThumbnailGallery(),
            ],
          ),
        ),

        verticalSpace(30),
        Expanded(flex: 3, child: _buildDetailsCard()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            product.thumbnail,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        verticalSpace(10),
        _buildThumbnailGallery(),
        verticalSpace(20),
        _buildDetailsCard(),
      ],
    );
  }

  Widget _buildThumbnailGallery() {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: product.images.map((img) {
          return Container(
            width: 70,
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(img, fit: BoxFit.cover),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withValues(alpha: 0.5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: product.title,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          verticalSpace(10),

          Row(
            children: [
              CustomText(title: "Brand: ${product.brand}", fontSize: 14),
              verticalSpace(10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(product.category),
              ),
            ],
          ),
          verticalSpace(20),
          CustomText(
            title: "\$${product.price.toStringAsFixed(2)}",
            fontSize: 28,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
          if (product.discountPercentage > 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: CustomText(
                title: "Discount: ${product.discountPercentage}% OFF",
                color: Palette.errorColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

          verticalSpace(20),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade600),
              horizontalSpace(5),
              CustomText(title: "${product.rating} / 5", fontSize: 14),
              horizontalSpace(10),
              CustomText(
                title: product.stock > 0 ? "In Stock" : "Out of Stock",
                color: product.stock > 0 ? Colors.green : Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          verticalSpace(10),
          CustomText(
            title: product.description,
            fontSize: 14,
            color: Colors.grey.shade700,
          ),

          verticalSpace(20),
          _buildInfoTile("Warranty", product.warrantyInformation),
          _buildInfoTile("Shipping Info", product.shippingInformation),
          _buildInfoTile("Availability", product.availabilityStatus),
          _buildInfoTile("Return Policy", product.returnPolicy),

          verticalSpace(30),

          CustomText(
            title: "Reviews",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),

          verticalSpace(10),

          ...product.reviews.map((review) => _buildReviewCard(review)),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CustomText(
            title: "$title: ",
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),

          Expanded(child: CustomText(title: value, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(
                5,
                (index) => Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
              horizontalSpace(8),
              CustomText(
                title: '${review.rating}/5',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
            ],
          ),

          verticalSpace(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: review.reviewerName,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                title: _formatDate(review.date),
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ],
          ),

          verticalSpace(4),

          CustomText(
            title: review.reviewerEmail,
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
          verticalSpace(10),
          CustomText(
            title: review.comment,
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
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
