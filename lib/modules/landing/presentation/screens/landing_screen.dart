import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/core/util/app_strings.dart';
import 'package:zetaton/modules/favorites/presentation/screens/favorites_screen.dart';
import 'package:zetaton/modules/home/presentation/screens/home/home_screen.dart';
import 'package:zetaton/modules/landing/presentation/controllers/landing_provider.dart';

enum TabItem { home, favorites }

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Scaffold(
        body: Consumer<NavigationProvider>(
          builder: (context, provider, _) {
            switch (provider.currentTab) {
              case TabItem.home:
                return const HomeScreen();
              case TabItem.favorites:
                return const FavoritesScreen();
            }
          },
        ),
        bottomNavigationBar: Consumer<NavigationProvider>(
          builder: (context, provider, _) {
            return BottomNavigationBar(
              currentIndex: provider.currentTab.index,
              onTap: (index) => provider.changeTab(TabItem.values[index]),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: AppStrings.homeTap,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: AppStrings.favoritesTap,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
