import 'package:hive/hive.dart';

class WallpaperRepository {
  Future<Box<List<String>>> openBox() async {
    await Hive.openBox<List<String>>('favoriteWallpapers');
    return Hive.box<List<String>>('favoriteWallpapers');
  }
}
