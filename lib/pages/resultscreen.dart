import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for using Clipboard

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(text),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: text));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Copied to clipboard'),
                        ));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text('Copy'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      
                      onPressed: () {
                        Clipboard.getData(Clipboard.kTextPlain).then((value) {
                          if (value != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Copied Text: ${value.text}'),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Clipboard is empty'),
                            ));
                          }
                        });
                      },
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.blueAccent, // Background color
                      // ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      
                      child: Text('Send'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
