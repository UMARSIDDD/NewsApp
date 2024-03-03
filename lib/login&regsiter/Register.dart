import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
// import 'package:newsapp/Widget/TextFields.dart';
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

  Future<void> submit(email, password) async {
    final body = {
      'email': email.toString(),
      'password': password.toString(),
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailTextController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: confirPasswordController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        String email =
                            emailTextController.text; // You can add email input
                        String password = passwordController.text;
                        String confirmpass = confirPasswordController.text;
                        if (password == confirmpass) {
                          Navigator.pushReplacementNamed(context, 'login/');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                const Center(child: Text("Or")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'login/');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.purple),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
