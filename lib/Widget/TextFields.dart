// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          filled: true,
          hintText: hintText,
          fillColor: Color(0xfff4f4f4),
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
