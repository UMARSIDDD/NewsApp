// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Widget/Sizedbox.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String sourceName;
  final String urlToImage;
  final String content;
  final String publishedAt;
  final String author;
  final String url;

  const NewsDetailPage(
      {super.key,
      required this.title,
      required this.description,
      required this.sourceName,
      required this.urlToImage,
      required this.content,
      required this.publishedAt,
      required this.author,
      required this.url});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final texttheme = Theme.of(context).textTheme;

    return Scaffold(
        body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Stack(children: [
            SizedBox(
              height: height * 0.4,
              width: double.infinity,
              child: ClipRRect(
                child: Image.network(
                  widget.urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
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
                  '${widget.sourceName}. ${widget.publishedAt}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                sizedH(context, 0.01),
                Text(widget.title,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                sizedH(context, 0.03),
                Text(
                  widget.description,
                  style: TextStyle(color: Colors.grey[700], fontSize: 20),
                ),
                sizedH(context, 0.02),
                TextButton(
                  onPressed: () async {
                    final url = Uri.parse(widget.url);
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
        ]));
  }
}
