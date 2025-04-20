import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4
    ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img.png', width: 150, height: 150),
            SizedBox(height: 5),
            Text(
              "FSS Connect",
              style: TextStyle(color: const Color.fromARGB(255, 110, 110, 109), fontSize: 27),
            ),
    
            SizedBox(height: 70),
            Text(
              "Bienvenue!",
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
