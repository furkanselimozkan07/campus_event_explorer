import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CampusEventExplorerApp());
}

class CampusEventExplorerApp extends StatelessWidget {
  const CampusEventExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Event Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2457B2)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7FC),
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
