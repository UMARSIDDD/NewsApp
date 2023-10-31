// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/Widget/TextFields.dart';
// import 'package:newsia/Components/Buttons.dart';

class MyRegisterPage extends StatefulWidget {
  // final Function? onTap;

  const MyRegisterPage({
    super.key,
  });

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();
  final confirPasswordController = TextEditingController();

  Future<void> submit(email, password, confirmPass) async {
    final body = {
      'email': email.toString(),
      'password': password.toString(),
      'password2': confirmPass.toString(),
    };
    const url = 'http://10.0.2.2:8000/api/reg/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: body,
    );
    if (response.statusCode == 201) {
      Navigator.pushReplacementNamed(context, 'login/');
    } else {
      print("Register error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register Page"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Text
                  Text(
                    "Let's create your account!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // This is for email
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Enter Email',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // This is for password
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Enter password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // This is for donfirm password
                  MyTextField(
                    controller: confirPasswordController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 900,
                    child: ElevatedButton(
                      onPressed: () {
                        String email =
                            emailTextController.text; // You can add email input
                        String password = passwordController.text;
                        String confirmpass = confirPasswordController.text;

                        submit(email, password, confirmpass);
                      },
                      child: Text(
                        "Register!",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // MyButton(
                  //   Ontap: () {},
                  //   text: 'Sign Up!',
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an account?", 
                        style: TextStyle(
                            // color: Colors.w,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'login/');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => LoginPage(),
                          //   ),
                        }, 
                        child: Text(
                          "Login Here!",
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
