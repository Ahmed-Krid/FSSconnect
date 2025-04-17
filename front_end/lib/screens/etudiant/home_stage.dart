import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Pour la sélection de fichiers
import 'dart:ui'; // Pour l'effet de flou

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

class _InternshipOffersPageState extends State<InternshipOffersPage>
    with SingleTickerProviderStateMixin {
  // Animation controller pour l'image de rafraîchissement
  late AnimationController _refreshController;
  bool _showRefreshImage = false;

  // Liste des stages disponibles
  final List<Map<String, String>> _availableInternships = [
    {
      'title': 'Stage Développeur Web - Entreprise X',
      'company': 'Entreprise X',
      'duration': '3 mois',
      'skills': 'HTML, CSS, JavaScript',
      'description':
          'Stage de développement web pour créer et maintenir des applications web modernes.',
      'location': 'Paris, France',
      'salary': '800€ / mois',
    },
    {
      'title': 'Stage Analyste Réseau - Entreprise Y',
      'company': 'Entreprise Y',
      'duration': '6 mois',
      'skills': 'Networking, TCP/IP',
      'description':
          'Stage d\'analyse réseau pour améliorer l\'infrastructure IT de l\'entreprise.',
      'location': 'Lyon, France',
      'salary': '950€ / mois',
    },
    {
      'title': 'Stage Data Scientist - Entreprise Z',
      'company': 'Entreprise Z',
      'duration': '4 mois',
      'skills': 'Python, Machine Learning, SQL',
      'description':
          'Stage en science des données pour analyser et modéliser des données complexes.',
      'location': 'Bordeaux, France',
      'salary': '1000€ / mois',
    },
    {
      'title': 'Stage Marketing Digital - Entreprise W',
      'company': 'Entreprise W',
      'duration': '5 mois',
      'skills': 'SEO, Réseaux sociaux, Content Marketing',
      'description':
          'Stage en marketing digital pour développer la présence en ligne de l\'entreprise.',
      'location': 'Marseille, France',
      'salary': '850€ / mois',
    },
  ];

  // Liste des stages affichés actuellement
  late List<Map<String, String>> internships;
  int currentIndex = 2; // Commencer avec les 2 premiers stages

  @override
  void initState() {
    super.initState();
    // Initialiser avec les deux premiers stages
    internships = _availableInternships.sublist(0, 2);

    // Initialiser le contrôleur d'animation
    _refreshController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _refreshController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showRefreshImage = false;
        });
        _refreshController.reset();
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  // Fonction pour actualiser les offres de stage
  void _refreshInternships() {
    // Afficher l'image de rafraîchissement
    setState(() {
      _showRefreshImage = true;
    });

    // Lancer l'animation
    _refreshController.forward();

    // Ajouter un délai pour simuler le chargement
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        if (currentIndex < _availableInternships.length) {
          // Ajouter un nouveau stage de la liste disponible
          internships.add(_availableInternships[currentIndex]);
          currentIndex++;

          // Afficher un message de confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nouvelle offre de stage ajoutée !'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Réinitialiser si tous les stages ont été ajoutés
          internships = _availableInternships.sublist(0, 2);
          currentIndex = 2;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Liste des stages réinitialisée'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offres de stages'),
        backgroundColor: const Color(0xFFA5C9B5),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshInternships,
            tooltip: 'Actualiser les offres',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Liste des stages
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: internships.length,
            itemBuilder: (context, index) {
              final internship = internships[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: InternshipCard(internshipData: internship),
              );
            },
          ),

          // Effet de flou sur l'arrière-plan pendant l'animation
          if (_showRefreshImage)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _refreshController,
                builder: (context, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5 * _refreshController.value,
                      sigmaY: 5 * _refreshController.value,
                    ),
                    child: Container(
                      color: Colors.white.withOpacity(
                        0.1 * _refreshController.value,
                      ),
                    ),
                  );
                },
              ),
            ),

          // Image de rafraîchissement (superposée)
          if (_showRefreshImage)
            Center(
              child: AnimatedBuilder(
                animation: _refreshController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + 0.2 * _refreshController.value,
                    child: Opacity(
                      opacity: 1.0 - 0.2 * _refreshController.value,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotationTransition(
                              turns: _refreshController,
                              child: Icon(
                                Icons.refresh,
                                size: 60,
                                color: const Color(0xFFA5C9B5),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Actualisation en cours...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA5C9B5),
                              ),
                            ),
                          ],
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

class InternshipCard extends StatelessWidget {
  final Map<String, String> internshipData;

  const InternshipCard({super.key, required this.internshipData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(216, 206, 181, 1).withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            internshipData['title'] ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Durée : ${internshipData['duration']} - Compétences requises : ${internshipData['skills']}',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ApplicationFormPage(internshipData: internshipData),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(216, 206, 181, 1),
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

class ApplicationFormPage extends StatefulWidget {
  final Map<String, String> internshipData;

  const ApplicationFormPage({super.key, required this.internshipData});

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _cvSelected = false;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _motivationController.dispose();
    super.dispose();
  }

  Future<void> _pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _cvSelected = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CV téléchargé avec succès'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun fichier sélectionné'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _resetForm() {
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
    _telephoneController.clear();
    _motivationController.clear();
    setState(() {
      _cvSelected = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulaire réinitialisé'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidature: ${widget.internshipData['company'] ?? ''}'),
        backgroundColor: const Color(0xFFA5C9B5),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetForm, // Réinitialiser le formulaire
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.internshipData['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _infoRow(
                    Icons.business,
                    'Entreprise: ${widget.internshipData['company']}',
                  ),
                  _infoRow(
                    Icons.location_on,
                    'Lieu: ${widget.internshipData['location'] ?? 'Non spécifié'}',
                  ),
                  _infoRow(
                    Icons.timer,
                    'Durée: ${widget.internshipData['duration']}',
                  ),
                  _infoRow(
                    Icons.euro,
                    'Rémunération: ${widget.internshipData['salary'] ?? 'Non spécifié'}',
                  ),
                  _infoRow(
                    Icons.psychology,
                    'Compétences: ${widget.internshipData['skills']}',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Description du poste:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.internshipData['description'] ??
                        'Aucune description disponible.',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Formulaire de candidature',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nomController,
                          decoration: const InputDecoration(
                            labelText: 'Nom',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _prenomController,
                          decoration: const InputDecoration(
                            labelText: 'Prénom',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _telephoneController,
                    decoration: const InputDecoration(
                      labelText: 'Téléphone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _cvSelected ? Icons.check_circle : Icons.upload_file,
                          color: _cvSelected ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _cvSelected
                                ? 'CV sélectionné'
                                : 'Télécharger votre CV',
                            style: TextStyle(
                              color:
                                  _cvSelected ? Colors.green : Colors.grey[700],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _pickCVFile,
                          child: const Text('Parcourir'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _motivationController,
                    decoration: const InputDecoration(
                      labelText: 'Lettre de motivation',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez rédiger une lettre de motivation';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!_cvSelected) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Veuillez télécharger votre CV avant de soumettre votre candidature.',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Candidature envoyée'),
                                  content: const Text(
                                    'Votre candidature a été envoyée avec succès. L\'entreprise vous contactera prochainement pour la suite du processus.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(216, 206, 181, 1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Soumettre',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
