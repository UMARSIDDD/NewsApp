import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for using Clipboard

import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultScreen extends StatefulWidget {
  final String scanText;

  const ResultScreen({Key? key, required this.scanText}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  //  String? summaryText;
  String summaryText = '';

  Future<void> sendDesc(desc) async {
    // String text = desc.replaceAll("\n", "");
    String text = desc.replaceAll("\n", "");

    // Replace " with an empty string
    text = text.replaceAll('"', "");
    final body = {'text': text};
    const url =
        'https://9614-103-248-31-54.ngrok-free.app/text-summarizer/summarize/';
    final uri = Uri.parse(url);
    print(uri);
    final response = await http.post(
      uri,
      body: body,
    );
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        summaryText = data['result']['summary_text'];
      });
      // print(data['result']['summary_text']);
      print("OK");
      // Navigator.pushReplacementNamed(context, 'login/');
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context)
  // String scannedTExt=scanText;
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(widget.scanText),
              SizedBox(height: 20),
              summaryText != null
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(summaryText!),
                      ),
                    )
                  : Container(), // Show card only when summaryText is available
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // sendDesc();
                      Clipboard.setData(ClipboardData(text: widget.scanText));
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
                      print(widget.scanText);
                      sendDesc(widget.scanText);
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
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
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
}
