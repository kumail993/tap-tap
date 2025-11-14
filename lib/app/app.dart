import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_task/config/routes/app_routes.dart';
import 'package:tap_task/config/theme/app_theme.dart';
import 'package:tap_task/config/theme/theme_cubit.dart';
import 'package:tap_task/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:tap_task/features/products/bloc/products_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1),
          boldText: false,
          highContrast: false,
          invertColors: false,
        ),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: 'Tap Task',
              debugShowCheckedModeBanner: false,
              theme: ThemeManager.instance.lightTheme,
              darkTheme: ThemeManager.instance.darkTheme,
              themeMode: themeMode,
              routerConfig: router,
              locale: const Locale('en'),
            );
          },
        ),
      ),
    );
  }
}
