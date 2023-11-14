import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zetaton/modules/authentication/data/models/user.dart';
import 'package:zetaton/routes/app_pages.dart';
import 'package:zetaton/services/user_provider.dart';

class RegisterViewModel with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> signup(BuildContext context) async {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String phoneNumber = phoneNumberController.text;

    if (!_validateForm(
        firstName, lastName, email, password, phoneNumber, context)) {
      return;
    }

    try {
      final UserCredential userCredential =
          await Provider.of<UserProvider>(context, listen: false)
              .auth
              .createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      final User? user = userCredential.user;

      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      await usersCollection.doc(user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'emailAddress': email
      });

      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          // Access the user document data
          AppUser userData =
              AppUser.fromMap(userSnapshot.data() as Map<String, dynamic>);
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Provider.of<UserProvider>(context, listen: false)
              .setAppUser(userData);
          // Do something with the user data
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          inspect(userData);
          Navigator.pushNamed(context, Routes.LANDING);

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => LandingScreen()));
        } else {
          print('User document not found');
        }
      }
      Navigator.pushNamed(context, Routes.LANDING);

      // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign Up Error'),
          content: Text('An error occurred during signup: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool _validateForm(String firstName, String lastName, String email,
      String password, String phoneNumber, BuildContext context) {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Validation Error'),
          content: const Text('Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }

    return true;
  }
}
