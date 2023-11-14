import 'package:flutter/material.dart';
import 'package:zetaton/modules/details/presentation/controllers/photo_details_screen.dart';
import 'package:zetaton/modules/favorites/presentation/screens/favorites_screen.dart';
import 'package:zetaton/modules/home/presentation/screens/home/home_screen.dart';
import 'package:zetaton/modules/landing/presentation/screens/landing_screen.dart';
import 'package:zetaton/modules/authentication/presentation/screens/login/login_screen.dart';
import 'package:zetaton/modules/authentication/presentation/screens/register/register_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.HOME: (context) => const HomeScreen(),
    Routes.FAVORITES: (context) => const FavoritesScreen(),
    Routes.DETAILS: (context) => PhotoDetailsPage(
          url: ModalRoute.of(context)!.settings.arguments as String,
        ),
    Routes.LOGIN: (context) => LoginPage(),
    Routes.REGISTER: (context) => const RegisterPage(),
    Routes.LANDING: (context) => const LandingScreen(),
  };
}
