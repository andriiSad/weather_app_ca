import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/res/strings.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateFormat('y').format(DateTime.now());
    return Container(
      height: context.screenHeight * 0.08,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          '$myNameSurname - $currentYear',
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
