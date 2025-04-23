import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Navigation item model
class NavItem {
  final IconData icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}

// Custom bottom navigation bar
class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items = [
    NavItem(icon: FontAwesomeIcons.calendarDay, label: 'Calendrier'),
    NavItem(icon: FontAwesomeIcons.clipboardCheck, label: 'Notes'),
    NavItem(icon: FontAwesomeIcons.house, label: 'Accueil'),
    NavItem(icon: FontAwesomeIcons.calendarDays, label: 'Emploi'),
    NavItem(icon: FontAwesomeIcons.book, label: 'Cours'),
  ];

  CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final pillColor = const Color(0xFF519465);
    final containerWidth = MediaQuery.of(context).size.width * 0.95;
    final itemWidth = containerWidth / widget.items.length;
    final selectedPosition = itemWidth * widget.currentIndex + (itemWidth / 2);

    return Center(
      child: SizedBox(
        width: containerWidth,
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(containerWidth, 70),
              painter: NavBarCutoutPainter(
                color: pillColor,
                selectedPosition: selectedPosition,
                cutoutRadius: 25,
                barRadius: 35,
              ),
            ),
            Positioned.fill(
              child: Row(
                children: List.generate(widget.items.length, (index) {
                  if (index == widget.currentIndex) {
                    return Expanded(child: Container());
                  }

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => widget.onTap(index),
                      child: Container(
                        color: Colors.transparent,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              widget.items[index].icon,
                              size: 22,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 4.5),
                            Text(
                              widget.items[index].label,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
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
            Positioned(
              top: -20,
              left: selectedPosition - 20 - (widget.currentIndex == 0 ? 4 : 0),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: pillColor,
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
                        widget.items[widget.currentIndex].icon,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.items[widget.currentIndex].label,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarCutoutPainter extends CustomPainter {
  final Color color;
  final double selectedPosition;
  final double cutoutRadius;
  final double barRadius;

  NavBarCutoutPainter({
    required this.color,
    required this.selectedPosition,
    required this.cutoutRadius,
    required this.barRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(barRadius, 0);
    path.lineTo(selectedPosition - cutoutRadius, 0);
    path.arcToPoint(
      Offset(selectedPosition + cutoutRadius, 0),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );
    path.lineTo(size.width - barRadius, 0);
    path.arcToPoint(
      Offset(size.width, barRadius),
      radius: Radius.circular(barRadius),
      clockwise: true,
    );
    path.lineTo(size.width, size.height - barRadius);
    path.arcToPoint(
      Offset(size.width - barRadius, size.height),
      radius: Radius.circular(barRadius),
      clockwise: true,
    );
    path.lineTo(barRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - barRadius),
      radius: Radius.circular(barRadius),
      clockwise: true,
    );
    path.lineTo(0, barRadius);
    path.arcToPoint(
      Offset(barRadius, 0),
      radius: Radius.circular(barRadius),
      clockwise: true,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Main page implementation using the custom navigation bar
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2; // Start with Home selected (index 2)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your main content goes here
      body: Center(
        child: Text('Page $_currentIndex content'),
      ),
      
      // Position the navigation bar at the bottom with proper padding
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      
      // Remove default bottom padding to avoid double padding
      extendBody: true,
    );
  }
}