import 'package:flutter/material.dart';

class LoginPageEntreprise extends StatefulWidget {
  @override
  _LoginPageStateEntreprise createState() => _LoginPageStateEntreprise();
}

class _LoginPageStateEntreprise extends State<LoginPageEntreprise> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companySiteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  String? _emailError, _companyNameError, _companySiteError, _passwordError;

  bool _validateForm() {
    bool isValid = true;

    setState(() {
      _emailError = _emailController.text.isEmpty ? "E-mail requis" : null;
      _companyNameError = _companyNameController.text.isEmpty ? "Nom entreprise requis" : null;
      _companySiteError = _companySiteController.text.isEmpty ? "Site entreprise requis" : null;
      _passwordError = _passwordController.text.length < 6 ? "Mot de passe doit avoir 6 caractères minimum" : null;

      if (_emailError != null || _companyNameError != null || _companySiteError != null || _passwordError != null) {
        isValid = false;
      }
    });

    return isValid;
  }

  void _register() {
    if (_validateForm()) {
      // Afficher une alerte d'inscription réussie
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Inscription réussie"),
          content: Text("Votre compte a été créé avec succès !"),
          actions: [
            TextButton(
              onPressed: () {
                /*
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ()),
              );
              */
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 11, 11, 11)),
      onPressed: () {
        Navigator.pop(context); // Retour à la page précédente
      },
    ),
  ),
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
                "Créer un compte",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildInputField("E-mail", _emailController, Icons.email, false, _emailError),
            _buildInputField("Nom Entreprise", _companyNameController, Icons.business, false, _companyNameError),
            _buildInputField("Site Entreprise", _companySiteController, Icons.public, false, _companySiteError),
            _buildInputField("Mot de passe", _passwordController, Icons.lock, true, _passwordError),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 56, 122, 58),  
                foregroundColor: Colors.white, 
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  ),
                  child: Text("créer", style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, IconData icon, bool isPassword, String? errorText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label *",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? !_passwordVisible : false,
          decoration: InputDecoration(
            hintText: "Entrez votre $label",
            filled: true,
            fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: const Color.fromARGB(255, 110, 110, 109), width: 2.0), // Contour plus visible lors de la sélection
                  borderRadius: BorderRadius.circular(18.0),
                ),
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            errorText: errorText,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
