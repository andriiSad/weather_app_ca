import 'package:equatable/equatable.dart';

class MainWeather extends Equatable {
  const MainWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.iconCode,
  });

  const MainWeather.empty()
      : this(
          id: 0,
          main: '_empty.main_',
          description: '_empty.description_',
          iconCode: '_empty.iconCode_',
        );

  final int id;
  final String main;
  final String description;
  final String iconCode;

  @override
  List<Object> get props => [id, main, description, iconCode];

  @override
  String toString() =>
      'MainWeather(id: $id, main: $main, description: $description, '
      'iconCode: $iconCode)';
}
