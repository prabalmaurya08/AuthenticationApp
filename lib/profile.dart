import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Map<String, dynamic>? userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .get();
        if (doc.exists) {
          setState(() {
            userData = doc.data() as Map<String, dynamic>;
            _isLoading = false;
          });
        } else {
          print("No data found for user");
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildDietPreferencesCard() {
    if (userData == null || userData!['diet_preferences'] == null)
      return Container();

    List<String> dietPreferences = List<String>.from(
      userData!['diet_preferences'],
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.restaurant_menu, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  "Diet Preferences",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children:
                  dietPreferences
                      .map((diet) => Chip(label: Text(diet)))
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : userData == null
              ? Center(child: Text("No user data found"))
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.blue),
                        title: Text("Full Name"),
                        subtitle: Text(
                          userData!['full_name'] ?? 'Not provided',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.wc, color: Colors.blue),
                        title: Text("Gender"),
                        subtitle: Text(
                          userData!['gender'] ?? 'Not provided',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.cake, color: Colors.blue),
                        title: Text("Birth Date"),
                        subtitle: Text(
                          userData!['birth_date'] ?? 'Not provided',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildDietPreferencesCard(),
                    SizedBox(height: 20),

                    // Edit Profile Button (Placeholder for future implementation)
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement Edit Profile logic here
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Edit Profile"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
