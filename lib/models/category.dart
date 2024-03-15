import 'package:flutter/material.dart';

class Category {
  // constructor functions for category
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  // properties for category
  final String id;
  final String title;
  final Color color;
}
