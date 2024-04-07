// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/Widget/Sizedbox.dart';
import 'package:newsapp/model/newsModelHeadline.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  final String category;
  const NewsList({super.key, required this.category});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<Article> newsItems = [];
  List<Article> LikedNews = [];

  @override
  void initState() {
    super.initState();
    LikedNews = newsItems;
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=in&category=${widget.category}&apiKey=498589495fa646459ebbf0ead08801c2';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final articles = data['articles'] as List<dynamic>;

      setState(() {
        newsItems =
            articles.map((dynamic item) => Article.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    final texttheme = Theme.of(context).textTheme;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView.builder(
          itemCount: newsItems.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final news = newsItems[index];
            return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    SizedBox(
                      height: height * 0.4,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Image.network(
                          news.urlToImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: IconButton(
                          color: Colors.white,
                          splashRadius: 1,
                          icon: Icon(
                            news.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: news.isLiked ? Colors.red : null,
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              news.isLiked = !news.isLiked;
                              LikedNews = newsItems
                                  .where((article) => article.isLiked)
                                  .toList();
                            });
                          }),
                    ),
                    Positioned(
                        left: 20,
                        top: 30,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black87,
                            ),
                          ),
                        ))
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${news.sourceName}. ${news.publishedAt}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        sizedH(context, 0.01),
                        Text(news.title,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        sizedH(context, 0.03),
                        Text(
                          news.description,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 20),
                        ),
                        sizedH(context, 0.02),
                        TextButton(
                          onPressed: () async {
                            final url = Uri.parse(news.url);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              // ignore: avoid_print
                              print("Can't launch $url");
                            }
                          },
                          child: const Text('Read More',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ]);
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => LikedArticle(
      //           likedArticles: LikedNews =
      //               newsItems.where((article) => article.isLiked).toList(),
      //         ),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.favorite),
      // ),
    );
  }
}
