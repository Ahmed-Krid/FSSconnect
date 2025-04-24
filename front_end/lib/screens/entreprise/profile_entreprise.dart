//page de profil de l'entreprise
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isNotificationsEnabled = false;
  bool isDarkMode = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[800] : const Color(0xFFF1E6D4),
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.grey[800] : const Color(0xFFF1E6D4),
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFF1E6D4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nom de l\'entreprise',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : const Color(0xFFF3F0F0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.grey[800]
                          : const Color(0xFFF3F0F0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nom de l\'entreprise:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? Colors.grey[700]
                                : const Color(0xFFD8EADE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            prefixIcon: Icon(Icons.person,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Adresse E-mail:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? Colors.grey[700]
                                : const Color(0xFFD8EADE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            prefixIcon: Icon(Icons.email,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Mot de passe:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        TextFormField(
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? Colors.grey[700]
                                : const Color(0xFFD8EADE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            prefixIcon: Icon(Icons.lock,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SwitchListTile(
                          title: Text('Activer les notifications',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black)),
                          value: isNotificationsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              isNotificationsEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF34C759),
                        ),
                        Divider(color: const Color.fromARGB(255, 43, 42, 42)),
                        SwitchListTile(
                          title: Text('Mode sombre',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black)),
                          value: isDarkMode,
                          onChanged: (bool value) {
                            setState(() {
                              isDarkMode = value;
                            });
                          },
                          activeColor: const Color(0xFF34C759),
                        ),
                        Divider(color: const Color.fromARGB(255, 43, 42, 42)),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Ici tu peux ajouter des actions pour l'enregistrement, mais pour l'instant ça ne fait rien
                              },
                              child: Text(
                                'Enregistrer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                                backgroundColor: Color(0xFF539867),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
