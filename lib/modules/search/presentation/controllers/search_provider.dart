import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zetaton/modules/home/domain/entities/get_images.dart';
import 'package:zetaton/modules/search/domain/use_case/get_images_for_search_use_case.dart';

class SearchProvider with ChangeNotifier {
  Timer? searchDebounce;

  final GetSearchImagesUseCase _getImagesUseCase;

  SearchProvider(this._getImagesUseCase);
  GetImages? getImages;
  Future<GetImages?> fetchWallpapers({required String query}) async {
    if (searchDebounce != null && searchDebounce!.isActive) {
      // Cancel the existing timer if it's active
      searchDebounce!.cancel();
    }
    print('33333333333');

    searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      final result = await _getImagesUseCase
          .call(GetImagesForSearchParameter(query: query));
      getImages = result;
      notifyListeners();
      print(result);
    });
    return getImages;
  }
}
