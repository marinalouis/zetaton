import 'package:zetaton/modules/home/domain/entities/get_images.dart';
import 'package:zetaton/modules/search/data/data_source/search_remote_data_source.dart';
import 'package:zetaton/modules/search/domain/base_repository/base_search_repository.dart';
import 'package:zetaton/modules/search/domain/use_case/get_images_for_search_use_case.dart';

class SearchRepository extends BaseSearchRepository {
  final BaseSearchRemoteDataSource _baseSearchRemoteDataSource;

  SearchRepository(this._baseSearchRemoteDataSource);

  @override
  Future<GetImages> getImages(GetImagesForSearchParameter parameter) async {
    final result = await _baseSearchRemoteDataSource.getImages(parameter);
    return result;
  }
}
