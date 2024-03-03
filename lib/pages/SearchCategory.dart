// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:newsapp/model/categoryModel.dart';
import 'package:newsapp/pages/SearchcatIn/newsListPage.dart';

class SearchCategory extends StatefulWidget {
  const SearchCategory({super.key});

  @override
  State<SearchCategory> createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  List<Categorys> filteredcategories = [];
  List<Categorys> categories = [
    Categorys("assets/image/index1.jpg", 'Health', false),
    Categorys("assets/image/index2.jpg", 'Politics', false),
    Categorys("assets/image/index3.jpg", 'Business', false),
    Categorys("assets/image/index4.jpg", 'Science', false),
    Categorys("assets/image/index5.jpg", 'Sports', false),
    Categorys("assets/image/index6.jpg", 'Technology', false),
    Categorys("assets/image/index7.jpg", 'Nature', false),
    Categorys("assets/image/index8.jpg", 'Science', false),
  ];
  @override
  void initState() {
    filteredcategories = categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Search Category",
            style: TextStyle(color: Colors.purple),
          ),
        ),
        // backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: ' Search categories',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black87,

                      // color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Theme.of(context).colorScheme.primary,
                    filled: true,
                  ),
                  onChanged: (text) {
                    setState(() {
                      filteredcategories = categories
                          .where((category) => category.name
                              .toLowerCase()
                              .contains(text.toLowerCase()))
                          .toList();

                      print(filteredcategories);
                    });
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                    height: height * 0.635,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return true;
                      },
                      child: GridView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.vertical,
                          itemCount: filteredcategories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 3),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsList(
                                          category: filteredcategories[index]
                                              .name
                                              .toLowerCase()),
                                    ));
                              },
                              child: Card(
                                color: Theme.of(context).colorScheme.background,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        filteredcategories[index].image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      filteredcategories[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
              ],
            ),
          ),
        ));
  }
}
