//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePageEns extends StatefulWidget {
  const ProfilePageEns({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageEns> {
  bool isNotificationsEnabled = false;
  bool isDarkMode = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[700] : const Color(0xFFCDC0AA),
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.grey[700] : const Color(0xFFCDC0AA),
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
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
              color: isDarkMode ? Colors.grey[700] : const Color(0xFFCDC0AA),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFD8EADE),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFF539867),
                          child: Icon(FontAwesomeIcons.plus,
                              size: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nom et prenom du prof',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
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
                color: isDarkMode ? Colors.grey[800] : const Color(0xFFF3EAEA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.grey[800]
                          : const Color(0xFFF3EAEA),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nom d\'utilisateur:',
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
                        const SizedBox(height: 15),
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
                        const SizedBox(height: 15),
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
                        const SizedBox(height: 15),
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
                        const Divider(color: Color.fromARGB(255, 43, 42, 42)),
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
                        const Divider(color: Color.fromARGB(255, 43, 42, 42)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                                backgroundColor: const Color(0xFF539867),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Enregistrer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
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
