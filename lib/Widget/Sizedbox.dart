import 'package:flutter/material.dart';

Widget sizedWH(BuildContext context, double a, double b) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return SizedBox(
    width: width * a,
    height: height * b,
  );
}

Widget sizedW(
  BuildContext context,
  double a,
) {
  final width = MediaQuery.of(context).size.width;

  return SizedBox(
    width: width * a,
  );
}

Widget sizedH(BuildContext context, double a) {
  final height = MediaQuery.of(context).size.height;
  return SizedBox(
    height: height * a,
  );
}
