import 'package:get_it/get_it.dart';
import 'package:zetaton/modules/home/data/data_source/home_remote_data_source.dart';
import 'package:zetaton/modules/home/data/repository.dart';
import 'package:zetaton/modules/home/domain/base_repository/base_home_repository.dart';
import 'package:zetaton/modules/home/domain/use_case/get_images_use_case.dart';
import 'package:zetaton/modules/home/presentation/controllers/home_provider.dart';
import 'package:zetaton/modules/search/data/data_source/search_remote_data_source.dart';
import 'package:zetaton/modules/search/data/repository.dart';
import 'package:zetaton/modules/search/domain/base_repository/base_search_repository.dart';
import 'package:zetaton/modules/search/domain/use_case/get_images_for_search_use_case.dart';
import 'package:zetaton/modules/search/presentation/controllers/search_provider.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    sl.registerFactory(() => WallpaperProvider(sl()));

    sl.registerLazySingleton(() => GetImagesUseCase(sl()));

    sl.registerLazySingleton<BaseHomeRepository>(() => HomeRepository(sl()));

    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSource());
    // ================
    sl.registerFactory(() => SearchProvider(sl()));

    sl.registerLazySingleton(() => GetSearchImagesUseCase(sl()));

    sl.registerLazySingleton<BaseSearchRepository>(
        () => SearchRepository(sl()));

    sl.registerLazySingleton<BaseSearchRemoteDataSource>(
        () => SearchRemoteDataSource());
  }
}
