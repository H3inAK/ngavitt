import 'package:flutter/material.dart';

class ChartData {
  final String name;
  final double percent;
  final Color color;

  ChartData({this.name, this.percent, this.color});
}

class Category {
  final String id;
  final String title;
  final Color color;
  final String image;

  const Category({
    this.id,
    this.title,
    this.color,
    this.image,
  });
}
