import 'package:flutter/material.dart';
import 'etudiant/home_page.dart';
import 'entreprise/login_entreprise.dart';
import 'enseignant/HomePageEnseignant.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  String _userType = 'Étudiant'; // Valeur par défaut
  bool _passwordVisible = false; // Pour gérer l'affichage du mot de passe

void _login() {
  setState(() {
    _usernameError = _usernameController.text.isEmpty ? "Veuillez entrer votre adresse e-mail." : null;
    _passwordError = _passwordController.text.isEmpty ? "Veuillez entrer votre mot de passe."
        : _passwordController.text.length < 6
            ? "Le mot de passe doit contenir au moins 6 caractères."
            : null;
  });

  if (_usernameError == null && _passwordError == null) {
    if (_userType == "Étudiant") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        ),
      );
    } else if (_userType == "Entreprise") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPageEntreprise()),
      );
    } else if (_userType == "Enseignant") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Remplace par la bonne page
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Se connecter",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            
           Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Text(
      "En tant que",
      style: TextStyle(fontSize: 18, color: Colors.black),
    ),
    SizedBox(width: 10),

    Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color:  Color(0xFFF3EAEA), 
          borderRadius: BorderRadius.circular(18.0), // Bord arrondi
          border: Border.all(color: const Color.fromARGB(255, 110, 110, 109), width: 1.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _userType,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
              onChanged: (String? newValue) {
                  setState(() {
                    _userType = newValue!;
                    // Réinitialiser les champs de texte et les erreurs
                    _usernameController.clear();
                    _passwordController.clear();
                    _usernameError = null;
                    _passwordError = null;
                  });
                },
            items: <String>['Étudiant', 'Entreprise', 'Enseignant']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  ],
),
            SizedBox(height: 20),
            // E-mail
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "E-mail *",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Entrez votre adresse e-mail",
                filled: true,
               fillColor: Color(0xFFF3EAEA), // Couleur plus claire pour le fond
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color.fromARGB(255, 110, 110, 109), width: 2.0), 
                  borderRadius: BorderRadius.circular(18.0),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.grey), // Icône pour l'email
              ),
            ),
            if (_usernameError != null) ...[
              SizedBox(height: 5),
              Text(_usernameError!, style: TextStyle(color: const Color.fromARGB(255, 62, 62, 62), fontSize: 14)),
            ],
            SizedBox(height: 10),

            // Mot de passe
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mot de passe *",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Entrez votre mot de passe",
                filled: true,
                fillColor: Color(0xFFF3EAEA), // Couleur plus claire pour le fond
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color.fromARGB(255, 110, 110, 109), width: 2.0), 
                  borderRadius: BorderRadius.circular(18.0),
                ),
                prefixIcon: Icon(Icons.vpn_key, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            if (_passwordError != null) ...[
              SizedBox(height: 5),
              Text(_passwordError!, style: TextStyle(color: const Color.fromARGB(255, 62, 62, 62), fontSize: 14)),
            ],
            SizedBox(height: 20),

            // Lien mot de passe oublié
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour "Mot de passe oublié"
                },
               child: Column(
               children: [
              Text(
              "Mot de passe oublié ?",
              style: TextStyle(
              color: Color.fromARGB(255, 62, 62, 62),
              ),
              ),
              SizedBox(height: 1), 
              Container(
              height:1 ,
              width: 145, 
              color: Color.fromARGB(255, 62, 62, 6),
              ),
                ],
              )
              )    
           ),

            SizedBox(height:20),
            ElevatedButton(
             onPressed: _login,
             style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 56, 122, 58),  
                foregroundColor: Colors.white,  
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), 
               
              ),
              child: Text(
                "Se connecter",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18, 
                ),
              ),
            ),
            SizedBox(height: 5),

            // Lien inscription
Align(
  alignment: Alignment.center,
  child: TextButton(
    onPressed: () {
      if (_userType == "Entreprise") {
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPageEntreprise()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Connexion Impossible"),
              content: Text("La connexion à la Fss connect est impossible pour ce type d'utilisateur."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    },
      child: Column(
    children: [
      Text(
        "J'ai pas de compte ?",
        style: TextStyle(
          color: Color.fromARGB(255, 62, 62, 6),
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 1), 
      Container(
        height:1 ,
        width: 130, 
        color: Color.fromARGB(255, 62, 62, 6),
      ),
    ],
  )
  )
 
  ),

          ],
        ),
      ),
    );
  }
}
