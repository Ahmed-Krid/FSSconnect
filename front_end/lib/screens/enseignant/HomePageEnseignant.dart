import 'package:flutter/material.dart';
import 'profile_enseignant.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasNotifications = false;

  @override
  void initState() {
    super.initState();
    checkNotifications();
  }

  void checkNotifications() {
    setState(() {
      hasNotifications = NotificationsPage.notifications.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        automaticallyImplyLeading: false, // Supprimer le bouton "Back"
        title: Row(
          children: [
            Icon(Icons.home, color: Colors.black),
            SizedBox(width: 8),
            Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
                checkNotifications();
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.notifications, color: Colors.black, size: 35),
                        if (hasNotifications)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Text("Les notifications", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  buildButton(context, "Mon compte", Icons.person, ProfilePageEns()),
                  buildButton(context, "Administration", Icons.chat, AdministrationPage()),
                  buildButton(context, "Envoyer un cours", Icons.note_alt, EnvoyerCoursPage()),
                  buildButton(context, "Emploi du temps", Icons.calendar_today, EmploiDuTempsPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String title, IconData icon, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
       backgroundColor: Color(0xFFD8EADE) ,// Couleur de fond du bouton
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(0), // Suppression du padding interne
        minimumSize: Size(75, 50), // Taille réduite du bouton
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.black),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  static List<String> notifications = ["Nouvelle notification", "Message important"];

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: NotificationsPage.notifications.isEmpty
          ? Center(child: Text("Aucune notification"))
          : ListView.builder(
              itemCount: NotificationsPage.notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(NotificationsPage.notifications[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        NotificationsPage.notifications.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}



class AdministrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Administration"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(child: Text("Page Administration")),
    );
  }
}

class EnvoyerCoursPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Envoyer un Cours"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(child: Text("Page Envoyer un Cours")),
    );
  }
}

class EmploiDuTempsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emploi du Temps"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(child: Text("Page Emploi du Temps")),
    );
  }
}
