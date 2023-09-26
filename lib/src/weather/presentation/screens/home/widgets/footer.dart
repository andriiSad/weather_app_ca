import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_ca/core/common/providers/theme_provider.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/res/strings.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateFormat('y').format(DateTime.now());
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) => Container(
        height: context.screenHeight * 0.08,
        color: !themeProvider.isDarkMode ? Colors.grey[300] : Colors.grey[800],
        child: Center(
          child: Text(
            '$myNameSurname - $currentYear',
            style: context.textTheme.bodyMedium!.copyWith(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
