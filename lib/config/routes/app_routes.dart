import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/config/supabase/supabase_config.dart';
import 'package:tap_task/core/widgets/layout.dart';
import 'package:tap_task/features/authentication/bloc/authentication_bloc.dart';
import 'package:tap_task/features/authentication/views/authentication_view.dart';
import 'package:tap_task/features/dashboard/views/dashboard_view.dart';
import 'package:tap_task/features/products/models/product_model.dart';
import 'package:tap_task/features/products/views/product_details.dart';
import 'package:tap_task/features/products/views/products_view.dart';

bool isUserLoggedIn() => SupabaseConfig.client.auth.currentUser != null;

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: const LoginView(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return DashboardLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardView(),
        ),
        GoRoute(
          path: '/dashboard/products',
          builder: (context, state) => const ProductsView(),
        ),
        GoRoute(
          path: '/dashboard/settings',
          builder: (context, state) => const DashboardView(),
        ),
      ],
    ),
    GoRoute(
      path: '/productDetails',
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetails(product: product);
      },
    ),
  ],
);
