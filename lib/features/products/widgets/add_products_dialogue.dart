import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_task/core/imports/common_imports.dart';
import 'package:tap_task/features/products/bloc/products_bloc.dart';
import 'package:tap_task/features/products/widgets/custom_form_field.dart';
import 'package:tap_task/features/products/widgets/glass_button.dart';

void showAddProductDialog(BuildContext context) {
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
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
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
                        child: GlassButton(
                          text: "Cancel",
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      horizontalSpace(16),
                      Expanded(
                        child: GlassButton(
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
