import 'package:equatable/equatable.dart';
import 'package:zetaton/core/base_use_case/base_use_case.dart';
import 'package:zetaton/modules/home/domain/entities/get_images.dart';
import 'package:zetaton/modules/search/domain/base_repository/base_search_repository.dart';

class GetSearchImagesUseCase
    extends BaseUseCase<GetImages, GetImagesForSearchParameter> {
  final BaseSearchRepository _baseSearchRepository;

  GetSearchImagesUseCase(this._baseSearchRepository);

  @override
  Future<GetImages> call(GetImagesForSearchParameter parameter) async {
    return await _baseSearchRepository.getImages(parameter);
  }
}

class GetImagesForSearchParameter extends Equatable {
  final String query;

  const GetImagesForSearchParameter({required this.query});

  @override
  List<Object?> get props => [query];
}
