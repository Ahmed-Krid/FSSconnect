import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

// 📌 APPLICATION PRINCIPALE
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF519465),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF519465),
          primary: const Color(0xFF519465),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

// 📌 PAGE PRINCIPALE AVEC LA NAVIGATION
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2; // Default to home tab

  // 📌 Liste des pages
  final List<Widget> _pages = [
    CalendarPage(),
    TasksPage(),
    HomePage(),
    EventsPage(),
    CoursPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex], // Affiche la page sélectionnée
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: PillNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              items: [
                NavItem(icon: FontAwesomeIcons.calendarDay, label: 'Calendrier'),
                NavItem(icon: FontAwesomeIcons.clipboardCheck, label: 'Notes'),
                NavItem(icon: FontAwesomeIcons.home, label: 'Accueil'),
                NavItem(icon: FontAwesomeIcons.calendarAlt, label: 'Emploi'),
                NavItem(icon: FontAwesomeIcons.book, label: 'Cours'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Navigation item model
class NavItem {
  final IconData icon;
  final String label;
  
  NavItem({required this.icon, required this.label});
}

// 📌 PILL NAVIGATION BAR
class PillNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<NavItem> items;
  final Color pillColor = const Color(0xFF519465);
  
  const PillNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Pill background
            Container(
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(items.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onItemTapped(index),
                      child: Container(
                        color: Colors.transparent,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              items[index].icon,
                              size: 20,
                              color: selectedIndex == index 
                                  ? Colors.transparent 
                                  : Colors.black,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              items[index].label,
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedIndex == index 
                                    ? Colors.transparent 
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            // Floating selected item
            Positioned(
              top: -20, // Position above the pill
              left: _calculateSelectedPosition(context),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: FaIcon(
                    items[selectedIndex].icon,
                    size: 24,
                    color: pillColor,
                  ),
                ),
              ),
            ),
            
            // Selected item label
            Positioned(
              bottom: 12,
              left: _calculateSelectedPosition(context) - 10,
              width: 70,
              child: Center(
                child: Text(
                  items[selectedIndex].label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  double _calculateSelectedPosition(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width * 0.85;
    final itemWidth = containerWidth / items.length;
    return itemWidth * selectedIndex + (itemWidth - 50) / 2;
  }
}

// 📌 PAGES EXEMPLES (VIDES POUR LE MOMENT)
class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("📅 Page du Calendrier")),
    );
  }
}

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("📋 Page des Tâches")),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("🏠 Page d'Accueil")),
    );
  }
}

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("🎉 Page des Événements")),
    );
  }
}

class CoursPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("📚 Page des Cours")),
    );
  }
}

