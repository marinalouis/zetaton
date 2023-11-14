import 'dart:convert';
import 'dart:developer';

import 'package:zetaton/core/util/api_constants.dart';
import 'package:zetaton/core/util/app_constants.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/modules/home/data/models/get_images_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseHomeRemoteDataSource {
  Future<GetImagesModel> getImages();
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  @override
  Future<GetImagesModel> getImages() async {
    String url({required String page, required String perPage}) =>
        '${ApiConstanst.baseUrl}/${ApiConstanst.domainHomeBaseUrl}?page=$page&per_page=$perPage';
    final response = await http.get(
        Uri.parse(url(
            page: AppConstants.pageNumber,
            perPage: AppConstants.perPageNumber)),
        headers: {
          'Authorization': ApiConstanst.apiKey,
        });
    inspect(response);
    if (response.statusCode == AppIntergers.statusCode) {
      final jsonData = json.decode(response.body);
      return GetImagesModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}
