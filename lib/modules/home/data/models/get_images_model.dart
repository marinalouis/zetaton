import 'package:zetaton/modules/home/domain/entities/get_images.dart';

class GetImagesModel extends GetImages {
  const GetImagesModel({required super.urlImages});

  factory GetImagesModel.fromJson(Map<String, dynamic> json) => GetImagesModel(
        urlImages: List<String>.from(
            json["photos"].map((oneImage) => oneImage["src"]["original"])),
      );
}
