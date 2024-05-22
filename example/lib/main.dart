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
<p>Before we address the above question, let us understand what would happen if one chooses not to invest. Assume you earn Rs.50,000/- per month, and you spend Rs.30,000/-towards your day-to-day living; this can include expenses like housing, food, transport, shopping, medical, etc. The balance of Rs.20,000/- is your monthly surplus.</p><p> </p><p>For the sake of simplicity, let us ignore the tax effect in this discussion.</p><p> </p><p>To drive the point across, let us make a few simple assumptions –</p>\r\n<ol>\r\n\t<li>The employer is kind enough to give you a 10% salary hike every year.</li>\r\n\t<li>The cost of living is likely to go up by 8% yearly.</li>\r\n\t<li>You are 30 years old and plan to retire at 50, this translates to 20 working years.</li>\r\n\t<li>You don’t intend to work after you retire.</li>\r\n\t<li>Your expenses are fixed, and you don’t foresee any other expenses.</li>\r\n\t<li>The balance cash of Rs.20,000/- per month is retained as hard cash.</li>\r\n</ol>
''',
        ),
      ),
    );
  }
}
