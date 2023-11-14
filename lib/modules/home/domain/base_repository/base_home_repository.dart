import 'package:zetaton/modules/home/domain/entities/get_images.dart';

abstract class BaseHomeRepository {
  Future<GetImages> getImages();
}
