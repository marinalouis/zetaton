import 'package:equatable/equatable.dart';

class GetImages extends Equatable {
  final List<String>? urlImages;
  const GetImages({required this.urlImages});

  @override
  List<Object?> get props => [urlImages];
}
