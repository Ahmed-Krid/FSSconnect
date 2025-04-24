//interface de stage
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offres de Stages',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const InternshipOffersPage(),
    );
  }
}

class InternshipOffersPage extends StatefulWidget {
  const InternshipOffersPage({super.key});

  @override
  State<InternshipOffersPage> createState() => _InternshipOffersPageState();
}

class _InternshipOffersPageState extends State<InternshipOffersPage> {
  // List of internship data that can be refreshed
  List<Map<String, String>> internships = [
    {
      'title': 'Stage Développeur Web - Entreprise X',
      'duration': '3 mois',
      'skills': 'HTML, CSS, JavaScript',
    },
    {
      'title': 'Stage Analyste Réseau - Entreprise Y',
      'duration': '6 mois',
      'skills': 'Networking, TCP/IP',
    },
    {
      'title': 'Stage Développeur Web - Entreprise X',
      'duration': '3 mois',
      'skills': 'HTML, CSS, JavaScript',
    },
  ];

  // Method to refresh the internship list
  void refreshInternships() {
    // This would typically fetch new data from an API
    // For now, we'll just show a snackbar to demonstrate the functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rafraîchissement des offres de stages...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Simulate a refresh by changing the order
    setState(() {
      internships.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFA5C9B5), // Light green color from the image
            child: SafeArea(
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      // Go back or show a message if there's nowhere to go back to
                      Navigator.maybePop(context).then((result) {
                        if (result == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Retour à la page précédente'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Offres de stages',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  // Refresh button
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.black),
                    onPressed: refreshInternships,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),

          // Internship listings
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: internships.length,
              itemBuilder: (context, index) {
                final internship = internships[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InternshipCard(
                    title: internship['title']!,
                    duration: internship['duration']!,
                    skills: internship['skills']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InternshipCard extends StatelessWidget {
  final String title;
  final String duration;
  final String skills;

  const InternshipCard({
    super.key,
    required this.title,
    required this.duration,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Durée : $duration - Compétences requises : $skills',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                // Show a snackbar when apply button is pressed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Candidature pour: $title'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(
                  0xFFD8CEB5,
                ), // Beige color from the image
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Se postuler',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
