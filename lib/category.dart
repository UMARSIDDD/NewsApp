// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/categoryModel.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // int selectedCard = -1;
  List<Categorys> selectedCategories = [];
  List<String> title = [];

  List<Categorys> categories = [
    Categorys("assets/image/index1.jpg", 'Healthcare', false),
    Categorys("assets/image/index2.jpg", 'Politics', false),
    Categorys("assets/image/index3.jpg", 'Business', false),
    Categorys("assets/image/index4.jpg", 'Culture', false),
    Categorys("assets/image/index5.jpg", 'Sports', false),
    Categorys("assets/image/index6.jpg", 'Technology', false),
    Categorys("assets/image/index7.jpg", 'Nature', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
    // Categorys("assets/image/index8.jpg", 'Fashion', false),
    // Categorys("assets/image/index8.jpg", 'Fashion', false),
    // Categorys("assets/image/index8.jpg", 'Fashion', false),
    // Categorys("assets/image/index8.jpg", 'Fashion', false),
    // Categorys("assets/image/index8.jpg", 'Fashion', false),
  ];
  // final String apiUrl = "dfhsd";
  // Future<void> sendDetail() async {
  //   final response = await http.post(Uri.parse(apiUrl));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final articles = data['articles'] as List<dynamic>;
  //   }

  Future<void> sendCategoriesToBackend(List<String> title) async {
    final String backendUrl = 'https://example.com/api/interests';

    try {
      final http.Response response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'interests': title}),
      );

      if (response.statusCode == 201) {
        print('Categories sent successfully');
      } else {
        print('Failed to send categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(children: [
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              const Center(
                child: Text(
                  "Pick your Interests",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Colors.purple),
                ),
              ),
              const Center(
                child: Text(
                  "We'll use this info to personalize your \n feed to recommend things you'll like.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                  height: height * 0.635,
                  child: GridView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 3),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final category = categories[index];
                        final isSelected =
                            selectedCategories.contains(category);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              setState(() {
                                category.isSelected = !category.isSelected;

                                if (isSelected) {
                                  selectedCategories.remove(category);
                                  title.remove(category.name);
                                } else {
                                  selectedCategories.add(category);
                                  title.add(category.name);
                                }
                                print(title);
                              });
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 4,
                                    color: category.isSelected
                                        ? Colors.purple
                                        : Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    categories[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  categories[index].name,
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
                      })),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'home/');
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.purple, fontSize: 20),
                  ))
            ],
          ),
        )),
      ]),
    );
  }
}
