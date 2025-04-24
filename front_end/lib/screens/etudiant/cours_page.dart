//Gestion des cours
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile_etudiant.dart';
//import 'profile_enseignant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoursPage(),
    );
  }
}

// Page de détails du cours
class CourseDetailPage extends StatelessWidget {
  final String courseName;
  const CourseDetailPage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: const Color(0xFF9AC1A6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () {
              print("Téléchargement du cours...");
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Détails du cours ici."),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CoursPage extends StatefulWidget {
  const CoursPage({super.key});

  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  @override
  Widget build(BuildContext context) {
    //barre superieur
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.circleUser,
                    color: Colors.black),
                onPressed: () {
                  // Naviguer vers la page de profil
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePage()), // Ouverture de la page profile
                  );
                },
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.solidCommentDots,
                    color: Colors.black),
                onPressed: () {},
              ),
              const Spacer(), // Permet de pousser l'icône de stage à droite
              IconButton(
                icon: const Icon(FontAwesomeIcons.graduationCap,
                    color: Colors.black),
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InternshipOffersPage()),
                  );*/
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Cours',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  color: const Color(0xFFCDC0AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24,
                    ),
                    title: Text(
                      'Mr. ${['Y', 'X', 'H'][index]} a publié un nouveau cours',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(
                                courseName:
                                    'Cours de: ${['Y', 'X', 'H'][index]}'),
                          ),
                        );
                      },
                      child: const Text(
                        'Voir cours',
                        style: TextStyle(
                          color: Color(0xFF519465),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
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
