import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zetaton/modules/authentication/data/models/user.dart';
import 'package:zetaton/routes/app_pages.dart';

class UserProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  AppUser? _loggedInUser;

  AppUser? get loggedInUser => _loggedInUser;

  void setAppUser(AppUser? loggedInUser) {
    _loggedInUser = loggedInUser;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    _loggedInUser = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.pushNamed(
      context,
      Routes.LOGIN, // Replace with the route name of your LoginPage
    );

    inspect(_loggedInUser);
  }
}
