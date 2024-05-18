import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Html Parser Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Html(
          config: HtmlConfig(
            onAnchorClick: (href) {
              log('Opening URL: $href');
              // Open the URL in a browser.
            },
          ),
          data: r'''
<p>This is a paragraph.</p>
<p>This is a paragraph with <strong>bold</strong> text.</p>
<p>This is a paragraph with <em>italic</em> text.</p>
<p>This is a paragraph with <a href="https://example.com">a link</a>, <strong>bold</strong> text, and <a href="https://example.com">another link</a>.</p>
<p>This is a paragraph with an image.<br/><img src="https://upload.wikimedia.org/wikipedia/en/a/a9/Example.jpg?20240301091138" alt="An image" style="width=200,height=200" />.</p>
''',
        ),
      ),
    );
  }
}
