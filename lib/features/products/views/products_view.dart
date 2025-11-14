import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/core/widgets/custom_searchfield.dart';
import 'package:tap_task/core/widgets/custom_skeleton.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/bloc/products_bloc.dart';
import 'package:tap_task/features/products/widgets/add_products_dialogue.dart';
import 'package:tap_task/features/products/widgets/glass_button.dart';
import 'package:tap_task/features/products/widgets/glass_panel.dart';
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
                                GlassButton(
                                  text: "Add Product",
                                  onTap: () => showAddProductDialog(context),
                                ),
                              ],
                            ),

                            verticalSpace(20),
                            GlassPanel(
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
                              child: GlassPanel(
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
}
