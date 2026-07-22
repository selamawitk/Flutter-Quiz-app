import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable {
  final String message;

  const AppFailure(this.message);

  const factory AppFailure.serverError(String message) = ServerFailure;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends AppFailure {
  const ServerFailure(super.message);
}

class CacheFailure extends AppFailure {
  const CacheFailure(super.message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}

class InvalidInputFailure extends AppFailure {
  const InvalidInputFailure(super.message);
}