import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';
import 'package:weather_app_ca/core/errors/failures.dart';

void main() {
  group('ServerFailure Class Tests', () {
    test('ServerFailure class should have correct props', () {
      const serverFailure1 =
          ServerFailure(message: 'Server Error', statusCode: 500);
      const serverFailure2 =
          ServerFailure(message: 'Server Error', statusCode: 500);

      expect(serverFailure1, equals(serverFailure2));
    });

    test('ServerFailure class should generate correct errorMessage', () {
      const serverFailure =
          ServerFailure(message: 'Server Error', statusCode: 500);

      expect(serverFailure.errorMessage, equals('500 Error: Server Error'));
    });

    test('ServerFailure.fromException should create a ServerFailure instance',
        () {
      const serverException =
          ServerException(message: 'Server Exception', statusCode: 503);
      final serverFailure = ServerFailure.fromException(serverException);

      expect(serverFailure.message, equals(serverException.message));
      expect(serverFailure.statusCode, equals(serverException.statusCode));
    });
  });
}
