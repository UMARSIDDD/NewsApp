// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/Widget/Sizedbox.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  final picker = ImagePicker();

  Future getimage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        return;
      }
    });
  }

  Future getgallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            imageprofile(),
            const Text("Umar"),
            const Text("umar@gmail.com"),
            sizedH(context, 0.03),
            ProfileTile(
              height: height,
              forward: Icons.person,
              text: 'My Account',
              press: () => {},
            ),
            sizedH(context, 0.03),
            ProfileTile(
              height: height,
              forward: Icons.help_center,
              text: 'Help Center',
              press: () => {},
            ),
            sizedH(context, 0.03),
            ProfileTile(
              height: height,
              forward: Icons.logout,
              text: 'LogOut',
              press: () => {Navigator.pushReplacementNamed(context, 'login/')},
            ),
          ],
        ),
      ),
    );
  }

  Widget picking() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        const Text(
          "Choose Profile Photo",
          style: TextStyle(fontSize: 20, fontFamily: "Montserrat"),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: () {
                  getimage();
                },
                icon: const Icon(Icons.camera, color: Colors.blue),
                label: const Text('Camera',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Montserrat",
                        color: Colors.black))),
            TextButton.icon(
                onPressed: () {
                  getgallery();
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.blue,
                ),
                label: const Text('Gallery',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Montserrat",
                        color: Colors.black)))
          ],
        )
      ]),
    );
  }

  Widget imageprofile() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            child: ClipOval(
                child: SizedBox(
              height: 120.0,
              width: 120.0,
              child: image == null
                  ? Image.asset(
                      'assets/image/index1.jpg',
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
            ))),
        Positioned(
            bottom: 0,
            right: 5,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                  onTap: () => {
                        showModalBottomSheet(
                            context: context, builder: ((builder) => picking()))
                      },
                  child: const Icon(
                    Icons.camera,
                    color: Colors.blue,
                  )),
            ))
      ]),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.height,
    required this.text,
    required this.forward,
    this.press,
  });

  final double height;
  final String text;
  final IconData forward;
  // final IconData backward;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.purple.withOpacity(0.1)),
        height: height * 0.07,
        child: Row(
          children: [
            Icon(forward),
            sizedW(context, 0.04),
            Expanded(
                child: Text(text,
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary))),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
