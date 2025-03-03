import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:intl/intl.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<Onboarding> {
  String? _selectedGender;
  DateTime? _selectedBirthDate;
  List<String> _selectedDiets = [];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  final List<String> _genders = ["Male", "Female", "Others"];
  final List<String> _dietaryPreferences = [
    "Vegan",
    "Vegetarian",
    "Keto",
    "Halal",
    "None",
  ];

  void _pickBirthDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthDate = pickedDate;
        _birthDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _saveUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No authenticated user found!");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'full_name': _fullNameController.text.trim(),
        'gender': _selectedGender,
        'birth_date':
            _selectedBirthDate != null
                ? DateFormat('dd-MM-yyyy').format(_selectedBirthDate!)
                : null,
        'diet_preferences': _selectedDiets,
      }, SetOptions(merge: true)); // Prevent overwriting existing data

      // Navigate to Profile page after saving
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    } catch (e) {
      print("Error saving user data: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to save data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 80, color: Colors.amber),
                Text(
                  "Complete Your Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: "Enter Full Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items:
                            _genders.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                        readOnly: true,
                        controller: _birthDateController,
                        decoration: InputDecoration(
                          labelText: 'Select Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today_sharp),
                        ),
                        onTap: () => _pickBirthDate(context),
                      ),

                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Diet Preferences",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Column(
                        children:
                            _dietaryPreferences.map((diet) {
                              return CheckboxListTile(
                                value: _selectedDiets.contains(diet),
                                title: Text(diet),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedDiets.add(diet);
                                    } else {
                                      _selectedDiets.remove(diet);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _saveUserData, // Save data on press
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
