import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class FavoritesProvider with ChangeNotifier {
  final Box<String> _favoriteWallpapersBox;

  FavoritesProvider(Box<String> favoriteWallpapersBox)
      : _favoriteWallpapersBox = favoriteWallpapersBox {
    _init();
  }

  Future<List<String>> getFavoriteWallpapers() async {
    // Simulating an asynchronous operation
    await Future.delayed(Duration(seconds: 1));

    return _favoriteWallpapersBox.values.toList();
  }

  Future<void> _init() async {
// await _favoriteWallpapersBox.openBox();
    notifyListeners();
  }
}
