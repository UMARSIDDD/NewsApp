// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:newsia/Components/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Widget/TextFields.dart';
import 'package:newsapp/login&regsiter/Register.dart';
import 'package:newsapp/pages/HomeScreen.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> submit(email, password) async {
    final body = {
      'username': email.toString(),
      'password': password.toString(),
    };
    const url = 'http://127.0.0.1/:8000/api/login/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, 'home/');
    } else {
      print("login error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),
                  //logo
                  Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Text
                  Text(
                    "Welcome to the app",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Enter Email',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Enter password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 55,
                    width: 900,
                    child: ElevatedButton(
                      onPressed: () {
                        String email = emailTextController.text;
                        String password = passwordController.text;
                        submit(email, password);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => HomeScreen(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Sign In!",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // MyButton(
                  //   Ontap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => MyCarousel(),
                  //       ),
                  //     );
                  //   },
                  //   text: 'Sign In!',
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(
                            // color: Colors.w,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'register/');
                        },
                        child: Text(
                          "Register Here!",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
