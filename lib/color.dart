import 'package:flutter/material.dart';
import 'dart:math';

Color rastgeleRenkOlustur() {
  return Color.fromARGB(
    150 + Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
  );
}