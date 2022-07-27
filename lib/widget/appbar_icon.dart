import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_news/provider/theme_provider.dart';

class ChangeThemeIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Icon(
       Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? Icons.light_mode
        : Icons.dark_mode
    );
  }
}