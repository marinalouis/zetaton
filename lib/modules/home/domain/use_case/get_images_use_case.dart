import 'package:zetaton/core/base_use_case/base_use_case.dart';
import 'package:zetaton/modules/home/domain/base_repository/base_home_repository.dart';
import 'package:zetaton/modules/home/domain/entities/get_images.dart';

class GetImagesUseCase extends BaseUseCase<GetImages, NoParameters> {
  final BaseHomeRepository _baseHomeRepository;

  GetImagesUseCase(this._baseHomeRepository);

  @override
  Future<GetImages> call(GetImages) async {
    return await _baseHomeRepository.getImages();
  }
}
