import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<T> call(Parameters parameter);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object?> get props => [];
}
