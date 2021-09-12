import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void debug_print(String value) {
  debugPrint(DateTime.now().toLocal().toString() + ': ' + value);
}
