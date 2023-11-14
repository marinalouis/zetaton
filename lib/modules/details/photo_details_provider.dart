import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoDetailsProvider with ChangeNotifier {
  final Box<String> _favoriteWallpapersBox;

  PhotoDetailsProvider(Box<String> favoriteWallpapersBox)
      : _favoriteWallpapersBox = favoriteWallpapersBox {
    _init();
  }

  List<String> get favoriteWallpapers {
    return _favoriteWallpapersBox.values.toList();
  }

  Future<void> _init() async {
// await _favoriteWallpapersBox.openBox();
    notifyListeners();
  }

  Future<void> addFavoriteWallpaper(String wallpaperUrl) async {
    _favoriteWallpapersBox.add(wallpaperUrl);
    notifyListeners();
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        throw Exception("Permission denied");
      }
    }
  }

  Future<Directory?> createNewDirectory() async {
    try {
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      final newDirectory =
          Directory("${appDocumentsDirectory.path}/new_directory");

      if (!newDirectory.existsSync()) {
        await newDirectory.create();
        return newDirectory;
      } else {
        return newDirectory;
      }
    } catch (e) {
      print("Error creating new directory: $e");
      return null;
    }
  }

  Future<void> downloadAndSaveImage(String imageUrl) async {
    try {
      await requestStoragePermission();

      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        print("Error: External storage directory not available");

        // Create a new directory
        final newDirectory = await createNewDirectory();

        return;
      }

      String? fileName = imageUrl.split("/").last;

      final String path = "${directory.path}/$fileName";

      // Enable debug mode for Flutter Downloader
      await FlutterDownloader.enqueue(
        url: imageUrl,
        savedDir: directory.path,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
        headers: {},
      );

      print("Image downloaded and saved to: $path");
    } catch (e) {
      print("Error: $e");
    }
  }
}
