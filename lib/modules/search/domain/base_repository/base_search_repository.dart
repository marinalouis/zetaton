import 'package:zetaton/modules/home/domain/entities/get_images.dart';
import 'package:zetaton/modules/search/domain/use_case/get_images_for_search_use_case.dart';

abstract class BaseSearchRepository {
  Future<GetImages> getImages(GetImagesForSearchParameter parameter);
}
