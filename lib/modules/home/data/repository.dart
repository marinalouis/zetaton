import 'package:zetaton/modules/home/data/data_source/home_remote_data_source.dart';
import 'package:zetaton/modules/home/domain/base_repository/base_home_repository.dart';
import 'package:zetaton/modules/home/domain/entities/get_images.dart';

class HomeRepository extends BaseHomeRepository {
  final BaseHomeRemoteDataSource _baseHomeRemoteDataSource;

  HomeRepository(this._baseHomeRemoteDataSource);

  @override
  Future<GetImages> getImages() async {
    final result = await _baseHomeRemoteDataSource.getImages();
    return result;
  }
}
