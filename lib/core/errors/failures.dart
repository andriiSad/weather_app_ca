import 'package:equatable/equatable.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is String || statusCode is int,
          'statusCode must be a String or int, not: $statusCode',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode '
      '${statusCode is String ? '' : ' Error'}: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  factory ServerFailure.fromException(
    ServerException exception,
  ) =>
      ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}
