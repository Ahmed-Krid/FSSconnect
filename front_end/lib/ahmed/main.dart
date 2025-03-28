import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/ahmed/screens/etudiant/home_page.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FSSconnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8BC34A),
          primary: const Color(0xFF8BC34A),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

