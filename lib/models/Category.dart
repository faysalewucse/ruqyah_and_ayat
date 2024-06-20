import 'package:flutter/material.dart';

class Screen {
  final String name;
  final IconData iconData;
  final Widget Function() page;

  Screen(this.name, this.iconData, this.page);
}