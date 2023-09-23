import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';

void main() {
  group('ServerException', () {
    test(
        'Two [ServerException] instances with the same properties '
        'should be equal', () {
      const exception1 =
          ServerException(message: 'Error message', statusCode: 404);
      const exception2 =
          ServerException(message: 'Error message', statusCode: 404);

      expect(exception1, equals(exception2));
    });

    test(
        '[ServerException] instances with different properties '
        'should not be equal', () {
      const exception1 =
          ServerException(message: 'Error message 1', statusCode: 404);
      const exception2 =
          ServerException(message: 'Error message 2', statusCode: 500);

      expect(exception1, isNot(equals(exception2)));
    });

    test('[ServerException] instances should have the correct properties', () {
      const exception =
          ServerException(message: 'Error message', statusCode: 404);

      expect(exception.message, equals('Error message'));
      expect(exception.statusCode, equals(404));
    });

    test('[ServerException] instances should have the correct props', () {
      const exception =
          ServerException(message: 'Error message', statusCode: 404);

      expect(exception.props, equals(['Error message', 404]));
    });
  });
}
