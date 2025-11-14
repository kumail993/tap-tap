import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/core/widgets/custom_searchfield.dart';
import 'package:tap_task/core/widgets/custom_skeleton.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/bloc/products_bloc.dart';
import 'package:tap_task/features/products/widgets/custom_form_field.dart';
import 'package:tap_task/features/products/widgets/products_card.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsBloc>().add(LoadProductsEvent());
    });
  }

  void _onSearch(String value) {
    context.read<ProductsBloc>().add(SearchProductsEvent(query: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              final products = state.filteredProducts;

              return LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2;
                  if (constraints.maxWidth > 1300) {
                    crossAxisCount = 5;
                  } else if (constraints.maxWidth > 1000) {
                    crossAxisCount = 4;
                  } else if (constraints.maxWidth > 700) {
                    crossAxisCount = 3;
                  }

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1500),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  title: "Products",
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                _glassButton(
                                  text: "Add Product",
                                  onTap: () => _showAddProductDialog(context),
                                ),
                              ],
                            ),

                            verticalSpace(20),
                            _glassPanel(
                              child: CustomSearchField(
                                controller: searchCtrl,
                                placeholder:
                                    'Search products by name or category...',
                                onChanged: _onSearch,
                                onClear: (_) => _onSearch(''),
                              ),
                            ),

                            verticalSpace(25),
                            Expanded(
                              child: _glassPanel(
                                padding: const EdgeInsets.all(20),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: 22,
                                        mainAxisSpacing: 22,
                                        childAspectRatio: 0.66,
                                      ),
                                  itemBuilder: (context, index) {
                                    final product = products[index];

                                    return CustomSkeleton(
                                      enabled: state.isLoading,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.push(
                                            '/productDetails',
                                            extra: product,
                                          );
                                        },
                                        child: GlassProductCard(
                                          product: product,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            verticalSpace(25),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _glassPanel({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.03),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _glassButton({required String text, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.15),
                  Colors.white.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                horizontalSpace(10),
                CustomText(
                  title: text,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Container(
                width: 420,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: 'Add Product',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),

                    verticalSpace(22),

                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: nameCtrl,
                            label: 'Product Name',

                            validator: (v) =>
                                v!.isEmpty ? "Enter product name" : null,
                          ),
                          verticalSpace(16),

                          CustomTextFormField(
                            controller: categoryCtrl,
                            label: 'Category',
                            validator: (v) =>
                                v!.isEmpty ? "Enter category" : null,
                          ),
                          verticalSpace(16),

                          CustomTextFormField(
                            controller: priceCtrl,
                            label: 'Price',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Invalid number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    verticalSpace(20),

                    Row(
                      children: [
                        Expanded(
                          child: _glassButton(
                            text: "Cancel",
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                        horizontalSpace(16),
                        Expanded(
                          child: _glassButton(
                            text: "Add",
                            onTap: () {
                              if (!formKey.currentState!.validate()) return;

                              context.read<ProductsBloc>().add(
                                AddProductEvent(
                                  name: nameCtrl.text.trim(),
                                  category: categoryCtrl.text.trim(),
                                  price: priceCtrl.text.trim(),
                                ),
                              );

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
