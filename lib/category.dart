// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'model/categoryModel.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedCard = -1;

  List<Categorys> categories = [
    Categorys("assets/image/index1.jpg", 'Healthcare', false),
    Categorys("assets/image/index2.jpg", 'Politics', false),
    Categorys("assets/image/index3.jpg", 'Business', false),
    Categorys("assets/image/index4.jpg", 'Culture', false),
    Categorys("assets/image/index5.jpg", 'Sports', false),
    Categorys("assets/image/index6.jpg", 'Technology', false),
    Categorys("assets/image/index7.jpg", 'Nature', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
    Categorys("assets/image/index8.jpg", 'Fashion', false),
  ];

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
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
              ),
              const Center(
                child: Text(
                  "We'll use this info to personalize your \n feed to recommend things you'll like.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              setState(() {
                                categories[index].isSelected =
                                    !categories[index].isSelected;
                              });
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 4,
                                    color: categories[index].isSelected
                                        ? Colors.blueAccent
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
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  ))
            ],
          ),
        )),
      ]),
    );
  }
}
