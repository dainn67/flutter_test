import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_app/providers/theme_provider.dart';

extension BuildContextExtensions<T> on BuildContext {
  bool get darkMode => watch<ThemeProvider>().darkMode;
}