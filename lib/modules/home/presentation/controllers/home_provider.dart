
import 'package:flutter/material.dart';
import 'package:zetaton/core/base_use_case/base_use_case.dart';

import 'package:zetaton/modules/home/domain/entities/get_images.dart';
import 'package:zetaton/modules/home/domain/use_case/get_images_use_case.dart';

class WallpaperProvider with ChangeNotifier {
  final GetImagesUseCase _getImagesUseCase;

  WallpaperProvider(this._getImagesUseCase);
  GetImages? getImages;
  // bool _isFetched = false;

  Future<void> fetchWallpapers() async {
    // if (_isFetched) return;
    final result = await _getImagesUseCase.call(const NoParameters());
    getImages = result;
    notifyListeners();
  }
}
