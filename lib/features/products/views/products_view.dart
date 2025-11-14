import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/config/constants/app_colors.dart';
import 'package:tap_task/core/widgets/custom_button.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsBloc>().add(LoadProductsEvent());
    });
    searchCtrl = TextEditingController();
  }

  void _onSearch(String value) {
    context.read<ProductsBloc>().add(
      SearchProductsEvent(query: searchCtrl.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomIconButton(
        minSize: Size(250, 51),
        maxSize: Size(250, 51),
        backgroundColor: Palette.blackColor,
        textColor: Colors.white,
        text: 'Add Product',
        onPressed: () {
          _showAddProductDialog(context);
        },
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final products = state.filteredProducts;

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;

              if (constraints.maxWidth > 1200) {
                crossAxisCount = 5;
              } else if (constraints.maxWidth > 900) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth > 600) {
                crossAxisCount = 3;
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomSearchField(
                      controller: searchCtrl,
                      placeholder: 'Search for a product',
                      onChanged: _onSearch,
                      onClear: (value) {
                        _onSearch('');
                      },
                    ),
                    verticalSpace(20),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1400),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.68,
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
                                child: ProductCard(product: product),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
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
        return AlertDialog(
          backgroundColor: Palette.whiteColor,
          surfaceTintColor: Palette.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: CustomText(title: 'Add Product', fontSize: 20),
          content: Form(
            key: formKey,
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: nameCtrl,
                    label: 'Product Name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(16),
                  CustomTextFormField(
                    controller: categoryCtrl,
                    label: 'Category',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter category';
                      }
                      return null;
                    },
                  ),

                  verticalSpace(16),
                  CustomTextFormField(
                    controller: priceCtrl,
                    label: 'Price',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Price must be a valid number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: CustomText(
                        title: 'Close',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                horizontalSpace(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<ProductsBloc>().add(
                        AddProductEvent(
                          name: nameCtrl.text,
                          category: categoryCtrl.text,
                          price: priceCtrl.text,
                        ),
                      );
                      context.pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        title: 'Add Product',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
