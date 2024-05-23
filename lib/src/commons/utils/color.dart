import 'package:flutter/material.dart';

Color stringToColor(String value) =>
    Color(int.parse('0xFF${value.replaceFirst('#', '')}'));