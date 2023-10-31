// ignore_for_file: unused_import, constant_identifier_names

import 'package:flutter/material.dart';

class Article {
  final String sourceName;
  final String author; 
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  bool isLiked;

  Article(
      {required this.title,
      required this.description,
      required this.url,
      required this.author,
      required this.publishedAt,
      required this.sourceName,
      required this.urlToImage,
      required this.content,
      this.isLiked = false});

  factory Article.fromJson(Map<String, dynamic> json) {
    const String ImageError =
        'https://play-lh.googleusercontent.com/8LYEbSl48gJoUVGDUyqO5A0xKlcbm2b39S32xvm_h-8BueclJnZlspfkZmrXNFX2XQ';
    return Article(
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      author: json['author'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      sourceName: json['source']['name'] ?? '',
      urlToImage: json['urlToImage'] ?? ImageError,
      content: json['content'] ?? '',
    );
  }
}
