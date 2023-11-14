import 'dart:convert';
import 'dart:developer';

import 'package:zetaton/core/util/api_constants.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/modules/home/data/models/get_images_model.dart';
import 'package:http/http.dart' as http;
import 'package:zetaton/modules/search/domain/use_case/get_images_for_search_use_case.dart';

abstract class BaseSearchRemoteDataSource {
  Future<GetImagesModel> getImages(GetImagesForSearchParameter parameter);
}

class SearchRemoteDataSource extends BaseSearchRemoteDataSource {
  @override
  Future<GetImagesModel> getImages(
      GetImagesForSearchParameter parameter) async {
    String url({required String query}) =>
        '${ApiConstanst.baseUrl}/${ApiConstanst.domainSearchBaseUrl}?query=$query';
    final response =
        await http.get(Uri.parse(url(query: parameter.query)), headers: {
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
