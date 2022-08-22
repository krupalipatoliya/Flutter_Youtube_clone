import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_one_advance/home_screen.dart';
import 'package:project_one_advance/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List data = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  data = prefs.getStringList('search') ?? [];
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home: const HomePage(),
    ),
  );
}
