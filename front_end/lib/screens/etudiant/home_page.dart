import 'package:flutter/material.dart';
import'package:front_end/widgets/top_navigation_bar.dart';
import 'package:front_end/widgets/bottom_navigation _bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; 
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const TopNavigationBar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildWelcomeSection(),
                        const SizedBox(height: 20),
                        Expanded(
                          child: _buildNotificationsSection(),
                        ),
                        // Add extra space at the bottom for the navigation bar
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Position the custom navigation bar at the bottom
          CustomBottomNavBar(
          currentIndex: _selectedIndex,
            onTap: _onItemSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Icon(Icons.person_outline, size: 40),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green[400],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      children: [
        _buildNotificationCard(
          icon: Icons.mail_outline,
          title: 'Unread messages',
          onTap: () {
            debugPrint('Unread messages tapped');
          },
        ),
        const SizedBox(height: 15),
        _buildNotificationCard(
          icon: Icons.calendar_today,
          title: 'You have an upcoming exam',
          onTap: () {
            debugPrint('Upcoming exam tapped');
          },
        ),
        const SizedBox(height: 15),
        _buildNotificationCard(
          icon: Icons.school_outlined,
          title: 'New courses were uploaded',
          onTap: () {
            debugPrint('New courses tapped');
          },
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Made bigger
        decoration: BoxDecoration(
          color: const Color(0xFFAED581),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Made bigger
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 28), // Made bigger
            ),
            const SizedBox(width: 20), // More spacing
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18, // Made bigger
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

