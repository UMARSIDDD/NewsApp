import 'package:flutter/foundation.dart';

class LikedArticlesProvider extends ChangeNotifier {
  List<String> _likedArticles = [];

  List<String> get likedArticles => _likedArticles;

  void addLikedArticle(String articleTitle) {
    _likedArticles.add(articleTitle);
    notifyListeners();
  }
}
