import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screen3 extends StatefulWidget {
  const Screen3({
    super.key,
  });

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  bool isLoading = false;

  List<dynamic> user = [];
  void fetchuser() async {
    const url =
        "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=498589495fa646459ebbf0ead08801c2";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);

      isLoading = true;
      setState(() {
        user = json['articles'];
      });
    } else {
      isLoading = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Like",
            style: TextStyle(color: Colors.purple),
          ),
        ),
        body: isLoading
            ? ListView.builder(
                itemCount: user.length,
                itemBuilder: (context, index) {
                  final pro = user[index];

                  return ListTile(
                    title: pro['source']['name'] != null
                        ? Text(pro['source']['name'])
                        : const Text(''),
                    isThreeLine: true,
                    subtitle: pro['title'] != null
                        ? Text(pro["title"])
                        : const Text(""),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: pro['urlToImage'] != null
                          ? NetworkImage(
                              pro['urlToImage'],
                            )
                          : const NetworkImage(image),
                    ),
                  );
                })
            : const Center(
                child: CircularProgressIndicator(
                color: Colors.blue,
              )));
  }
}

const image =
    'https://i1.wp.com/www.mtctutorials.com/wp-content/uploads/2019/04/Breaking-News-Free-PNG-Transparent-Ticker-Download-by-MTC-Tutorials.png?ssl=1';
