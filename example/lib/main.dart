import 'package:example/example.dart';
import 'package:flutter/material.dart';

void main() => runApp(const HtmlToFlutterExample());

class HtmlToFlutterExample extends StatelessWidget {
  const HtmlToFlutterExample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTML to Flutter playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Example(),
    );
  }
}
