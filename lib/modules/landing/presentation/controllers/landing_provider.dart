import 'package:flutter/material.dart';
import 'package:zetaton/modules/landing/presentation/screens/landing_screen.dart';

class NavigationProvider with ChangeNotifier {
  TabItem _currentTab = TabItem.home;

  TabItem get currentTab => _currentTab;

  void changeTab(TabItem tabItem) {
    _currentTab = tabItem;
    notifyListeners();
  }
}
