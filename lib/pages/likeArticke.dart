import 'package:flutter/material.dart';

import '../model/newsModelHeadline.dart';

class LikedArticle extends StatefulWidget {
  
  final List<Article>? likedArticles;

  const LikedArticle({super.key, this.likedArticles});

  @override
  State<LikedArticle> createState() => _LikedArticleState();
}

class _LikedArticleState extends State<LikedArticle> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.likedArticles!.length,
          itemBuilder: (context, index) {
            // final pro = user[index];
            final likearticle = widget.likedArticles![index];
            return ListTile(
              title: Text(likearticle.title),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                backgroundImage: NetworkImage(
                  likearticle.urlToImage,
                  // fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
