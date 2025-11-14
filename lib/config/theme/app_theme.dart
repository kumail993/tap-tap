import 'package:tap_task/core/imports/common_imports.dart';

class ThemeManager {
  static final instance = ThemeManager();
  static final ThemeData _lightTheme = ThemeData(
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.whiteColor,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Palette.whiteColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Palette.whiteColor,
      selectedItemColor: Palette.primaryColor,
      unselectedItemColor: Palette.blackColor,
      selectedLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.primaryColor,
      foregroundColor: Palette.whiteColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Palette.blackColor,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Palette.blackColor,
      ),
      isDense: true,
      isCollapsed: true,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(color: Palette.blackColor),
        bodyLarge: TextStyle(color: Palette.blackColor),
        titleLarge: TextStyle(color: Palette.blackColor),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.primaryColor,
      brightness: Brightness.light,
    ),
    canvasColor: Palette.whiteColor,
    useMaterial3: true,
  );
  static final ThemeData _darkTheme = ThemeData(
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.black,
      selectedItemColor: Palette.primaryColor,
      unselectedItemColor: Colors.grey[400],
      selectedLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      type: BottomNavigationBarType.fixed,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Palette.whiteColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      isDense: true,
      isCollapsed: true,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.primaryColor,
      brightness: Brightness.dark,
    ),
    canvasColor: Colors.black,
    useMaterial3: true,
  );

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
}
