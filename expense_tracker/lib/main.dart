import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
//import 'package:flutter/services.dart';

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 20, 99, 187),
  brightness: Brightness.dark,
);
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fun) {
    runApp(
    MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 10, 48, 91),
        foregroundColor: Colors.white,
      ),
      
    ),
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 44, 20, 165)),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 105, 96, 139),
        foregroundColor: Colors.grey,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 44, 20, 165),
        ),
      ),
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
    themeMode: ThemeMode.system,
      home: Expenses(),
    )
  );
//  });
}