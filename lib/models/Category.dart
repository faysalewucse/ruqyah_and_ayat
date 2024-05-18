import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData iconData;
  final Widget Function() page;

  Category(this.name, this.iconData, this.page);
}