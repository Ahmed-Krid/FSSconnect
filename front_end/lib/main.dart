import 'package:flutter/material.dart';
import 'widgets/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSS Connect',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2; // Start with Home selected

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text('Calendrier'));
      case 1:
        return const Center(child: Text('Fiche des notes'));
      case 2:
        return const Center(child: Text('Home'));
      case 3:
        return const Center(child: Text('Emploi du temps'));
      case 4:
        return const Center(child: Text('Cours'));
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FSS Connect'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}