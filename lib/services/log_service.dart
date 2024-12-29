import 'package:flutter/cupertino.dart';

void printSuccess(String text) {
  debugPrint('✅ $text');
}

void printWarning(String text) {
  debugPrint('⚠️ $text');
}

void printError(String text) {
  debugPrint('❌ $text');
}