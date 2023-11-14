import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zetaton/modules/authentication/data/models/user.dart';
import 'package:zetaton/services/user_provider.dart';

import '../../../../routes/app_pages.dart';

class AuthViewModel with ChangeNotifier {
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await Provider.of<UserProvider>(context, listen: false)
              .auth
              .signInWithEmailAndPassword(
                email: email,
                password: password,
              );
      User? user = userCredential.user;
      inspect(user);
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          Provider.of<UserProvider>(context, listen: false).setUser(user);

          // Access the user document data
          AppUser userData =
              AppUser.fromMap(userSnapshot.data() as Map<String, dynamic>);

          Provider.of<UserProvider>(context, listen: false)
              .setAppUser(userData);
          // Do something with the user data
          inspect(userData);

          // Store the login status using SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          Navigator.pushNamed(context, Routes.LANDING);
        } else {
          print('User document not found');
        }
      } // Do something after successful login, such as navigating to another screen
    } catch (e) {
      // Handle login errors
      print('Login error: $e');
    }
  }
}
