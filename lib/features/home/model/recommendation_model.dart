import 'package:flutter/material.dart';

class RecommendationModel {
  final String title;
  final MaterialColor color;
  final String duration;
  final String slogan;
  final String author;
  final String season;  // <-- TAMBAH BARIS INI

  RecommendationModel({
    required this.title,
    required this.color,
    required this.duration,
    required this.slogan,
    required this.author,
    required this.season,  // <-- TAMBAH BARIS INI
  });
}