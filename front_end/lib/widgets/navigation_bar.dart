import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  int _oldIndex = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
    _oldIndex = _currentIndex;
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _positionAnimation = Tween<double>(
      begin: _oldIndex.toDouble(),
      end: _currentIndex.toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInBack,
      ),
    );
  }

  @override
  void didUpdateWidget(CustomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _oldIndex = oldWidget.selectedIndex;
      _currentIndex = widget.selectedIndex;
      _positionAnimation = Tween<double>(
        begin: _oldIndex.toDouble(),
        end: _currentIndex.toDouble(),
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInBack,
        ),
      );
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Custom pill with animated bump
            AnimatedBuilder(
              animation: _positionAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: NavBarPainter(
                    selectedPosition: _positionAnimation.value,
                    color: const Color(0xFF1B5E20),
                  ),
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(5, (index) {
                        return NavBarItem(
                          icon: _getIconData(index),
                          label: _getLabel(index),
                          isSelected: widget.selectedIndex == index,
                          onTap: () => widget.onItemSelected(index),
                          showIcon: true,
                          animationValue: _positionAnimation.value,
                          index: index,
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  IconData _getIconData(int index) {
    switch (index) {
      case 0: return Icons.calendar_today;
      case 1: return Icons.note;
      case 2: return Icons.home;
      case 3: return Icons.access_time;
      case 4: return Icons.book;
      default: return Icons.home;
    }
  }
  String _getLabel(int index) {
    switch (index) {
      case 0: return 'Calendrier';
      case 1: return 'Notes';
      case 2: return 'Home';
      case 3: return 'Emploit';
      case 4: return 'Course';
      default: return 'Home';
    }
  }
}

class NavBarPainter extends CustomPainter {
  final double selectedPosition;
  final Color color;
  NavBarPainter({
    required this.selectedPosition,
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final width = size.width;
    final height = size.height;
    final itemWidth = width / 5;
    final selectedItemCenter = itemWidth * selectedPosition + itemWidth / 2;
    final path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);
    final bumpStart = selectedItemCenter - 35;
    path.lineTo(bumpStart, 0);
    path.quadraticBezierTo(
      selectedItemCenter - 25, 0,
      selectedItemCenter - 25, -15
    );
    path.quadraticBezierTo(
      selectedItemCenter - 15, -40,
      selectedItemCenter, -40
    );
    path.quadraticBezierTo(
      selectedItemCenter + 15, -40,
      selectedItemCenter + 25, -15
    );
    path.quadraticBezierTo(
      selectedItemCenter + 25, 0,
      selectedItemCenter + 35, 0
    );
    path.lineTo(width - 20, 0);
    path.quadraticBezierTo(width, 0, width, 20);
    path.lineTo(width, height - 20);
    path.quadraticBezierTo(width, height, width - 20, height);
    path.lineTo(20, height);
    path.quadraticBezierTo(0, height, 0, height - 20);
    path.close();
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant NavBarPainter oldDelegate) {
    return oldDelegate.selectedPosition != selectedPosition || oldDelegate.color != color;
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showIcon;
  final double animationValue;
  final int index;
  const NavBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.showIcon = true,
    this.animationValue = 0,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final distance = (animationValue - index).abs();
    final upwardTranslation = isSelected ? -35.0 : (distance < 0.5 ? -20.0 * (1.0 - distance * 2.0) : 0.0);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              transform: Matrix4.translationValues(0, upwardTranslation, 0),
              child: Icon(
                icon,
                color: Colors.white,
                size: isSelected ? 28 : 24,
              ),
            ),
            SizedBox(height: isSelected ? 8 : 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}