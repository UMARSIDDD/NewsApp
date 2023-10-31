// ignore_for_file: unused_local_variable

import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/newsModelHeadline.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> categories = ['Technology', 'science','sports','politics'];

  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=96b9899434d04821acdb41e4e74be3ce';

  List<Article> newsData = [];
  List<Article> newsEver = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchRandomNews();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = data['articles'] as List<dynamic>;

      setState(() {
        newsData = articles.map((dynamic e) => Article.fromJson(e)).toList();
      });
    } else {
      throw Exception('Failed to load news data');
    }
  }

  String getRandomCategory() {
    final random = Random();

    final randomIndex = random.nextInt(categories.length);
    print(randomIndex);
    return categories[randomIndex];
  }

  Future<void> fetchRandomNews() async {
    final randomCategory = getRandomCategory();

    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=$randomCategory&apiKey=96b9899434d04821acdb41e4e74be3ce'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      isLoading = true;
      setState(() {
        newsEver = data['articles']
            .map<Article>((evernew) => (Article.fromJson(evernew)))
            .toList();
        // print(newsEver);
      });
    } else {
      isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return isLoading
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Newss'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: newsEver.length,
                        itemBuilder: (context, index) {
                          final item = newsEver[index];
                          return InkWell(
                            onTap: () async {
                              final url = Uri.parse(item.url);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                // ignore: avoid_print
                                print("Can't launch $url");
                              }

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => NewsDetailPage(
                              //           title: item.title,
                              //           description: item.description,
                              //           sourceName: item.sourceName,
                              //           urlToImage: item.urlToImage,
                              //           content: item.content,
                              //           publishedAt: item.publishedAt,
                              //           author: item.author,
                              //           url: item.url,
                              //         )));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide.none),
                              elevation: 5.0,
                              margin: const EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    item.urlToImage,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  item.sourceName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(item.title),
                                isThreeLine: true,

                                // subtitle
                                //     Text(item['description'] ?? "No Description aailable"),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ));
  }
}
