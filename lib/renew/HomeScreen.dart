// // ignore_for_file: unused_local_variable

// import 'dart:math';

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:http/http.dart' as http;
// import 'package:newsapp/Widget/Sizedbox.dart';
// import 'package:newsapp/model/newsModelHeadline.dart';

// import 'homeScreen in/NewsDetail.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   HomeScreenState createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   List<String> categories = [
//     'Technology',
//     'Sports',
//     'Politics',
//     'Entertainment',
//     'Science',
//     'Health',
//   ];

//   final String apiUrl =
//       'https://newsapi.org/v2/top-headlines?country=us&apiKey=96b9899434d04821acdb41e4e74be3ce';

//   List<Article> newsData = [];
//   List<Article> newsEver = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     fetchRandomNews();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final articles = data['articles'] as List<dynamic>;

//       setState(() {
//         newsData = articles.map((dynamic e) => Article.fromJson(e)).toList();
//       });
//     } else {
//       throw Exception('Failed to load news data');
//     }
//   }

//   String getRandomCategory() {
//     final random = Random();
//     final randomIndex = random.nextInt(categories.length);
//     return categories[randomIndex];
//   }

//   Future<void> fetchRandomNews() async {
//     final randomCategory = getRandomCategory();
//     final response = await http.get(
//       Uri.parse(
//           'https://newsapi.org/v2/top-headlines?country=us&category=$randomCategory&apiKey=96b9899434d04821acdb41e4e74be3ce'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       setState(() {
//         newsEver = data['articles']
//             .map<Article>((evernew) => (Article.fromJson(evernew)))
//             .toList();
//         print(newsEver);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Newss'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 autoPlay: true,
//                 height: height * 0.4,
//                 enableInfiniteScroll: true,
//                 // enlargeCenterPage: true,
//               ),
//               items: newsData
//                   .where((item) => item.urlToImage != false)
//                   .map((item) {
//                 return InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => NewsDetailPage(
//                               title: item.title,
//                               description: item.description,
//                               sourceName: item.sourceName,
//                               urlToImage: item.urlToImage,
//                               content: item.content,
//                               publishedAt: item.publishedAt,
//                               author: item.author,
//                               url: item.url,
//                             )));
//                   },
//                   child: Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               side: BorderSide.none),
//                           elevation: 2,
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: height * 0.2,
//                                 width: double.infinity,
//                                 child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: Image.network(
//                                       item.urlToImage,
//                                       fit: BoxFit.cover,
//                                     )),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   item.title,
//                                   style: const TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               // Padding(
//                               //   padding: EdgeInsets.all(8.0),
//                               //   child: Text(
//                               //     item['description'] ??
//                               //         'No description available',
//                               //     style: TextStyle(fontSize: 16.0),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//             sizedH(context, 0.02),
//             Expanded(
//               child: Material(
//                 // clipBehavior: Clip.hardEdge,
//                 color: Theme.of(context).colorScheme.primary,
//                 borderRadius: BorderRadius.circular(10),
//                 // borderOnForeground: true,
//                 elevation: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.builder(
//                     itemCount: newsEver.length,
//                     itemBuilder: (context, index) {
//                       final item = newsEver[index];
//                       return InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => NewsDetailPage(
//                                     title: item.title,
//                                     description: item.description,
//                                     sourceName: item.sourceName,
//                                     urlToImage: item.urlToImage,
//                                     content: item.content,
//                                     publishedAt: item.publishedAt,
//                                     author: item.author,
//                                     url: item.url,
//                                   )));
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               side: BorderSide.none),
//                           elevation: 5.0,
//                           margin: const EdgeInsets.all(5.0),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               radius: 25,
//                               backgroundImage: NetworkImage(
//                                 item.urlToImage,
//                                 // fit: BoxFit.cover,
//                               ),
//                             ),

//                             title: Text(item.title),
//                             // subtitle:
//                             //     Text(item['description'] ?? "No Description aailable"),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
