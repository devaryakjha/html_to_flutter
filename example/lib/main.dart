import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html_to_flutter_kit/html_to_flutter_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _input = "";

  @override
  void initState() {
    super.initState();
    _input = """<div>
              <h1 color="red">Hello, Flutter!</h1>
              <p>This is a sample HTML content converted to Flutter widgets.</p>
              <p>It supports <strong>bold</strong>, <em>italic</em>, <u>underline</u>, <strike>strike</strike>, and <a href="https://flutter.dev">links</a>.</p>
              <p>It supports unordered lists:</p>
              <ul>
                <li color="#ff0000">Item 1</li>
                <li color="hsl(0, 100%, 50%)">Item 2</li>
                <li color="rgb(255,0,0)">Item 3</li>
              </ul>
             <p>and ordered lists:</p>
              <ol>
                <li style="color:">Item 1</li>
                <li>Item 2</li>
                <li>Item 3</li>
              </ol>
              <p>It supports images:</p>
              <span>
                <img src="https://picsum.photos/seed/abc/200?grayscale" margin="0 16px 0 0" />
                <img src="https://picsum.photos/seed/def/200" margin="0 16px 0 0" />
                <img src="https://picsum.photos/seed/ghi/200" margin="0 16px 0 0" />
              </span>
              <p>It supports tables:</p>
              <table>
                <thead>
                  <tr>
                    <th>Header 1</th>
                    <th>Header 2</th>
                    <th>Header 3</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Row 1, Cell 1</td>
                    <td>Row 1, Cell 2</td>
                    <td>Row 1, Cell 3</td>
                  </tr>
                  <tr>
                    <td>Row 2, Cell 1</td>
                    <td>Row 2, Cell 2</td>
                    <td>Row 2, Cell 3</td>
                  </tr>
                  <tr>
                    <td>Row 3, Cell 1</td>
                    <td>Row 3, Cell 2</td>
                    <td>Row 3, Cell 3</td>
                  </tr>
                </tbody>
              </table>
            </div>""";
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final htmlConfig = HtmlConfig(
      onTap: (url, [attributes, element]) {
        log('Tapped on $url');
        log('Attributes: $attributes');
        log('Element: $element');
      },
      extensions: const [
        TableExtension(),
        IframeExtextion(),
      ],
      styleOverrides: {
        'h1': Style(
          margin: Spacing.px(top: 30),
          textStyle: const TextStyle(fontSize: 24),
        ),
        'h2': Style(
          margin: Spacing.px(top: 20),
          textStyle: const TextStyle(fontSize: 20),
        ),
        'h3': Style(
          margin: Spacing.px(top: 15),
          textStyle: const TextStyle(fontSize: 18),
        ),
        'h4': Style(
          margin: Spacing.px(top: 10),
          textStyle: const TextStyle(fontSize: 16),
        ),
        'h5': Style(
          margin: Spacing.px(top: 5),
          textStyle: const TextStyle(fontSize: 14),
        ),
        'h6': Style(
          margin: Spacing.px(top: 5),
          textStyle: const TextStyle(fontSize: 12),
        ),
        'p': Style(
          margin: Spacing.px(top: 10, bottom: 20),
          textStyle: const TextStyle(fontSize: 16),
        ),
        'ul': Style(
          margin: Spacing.px(top: 10, bottom: 10),
          padding: Spacing.px(left: 20),
        ),
        'ol': Style(
          margin: Spacing.px(top: 10, bottom: 10),
          padding: Spacing.px(left: 20),
        ),
      },
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Enter HTML content below:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          initialValue: _input,
                          onChanged: (value) {
                            _input = value;
                            if (mounted) setState(() {});
                          },
                          maxLines: 100,
                          decoration: const InputDecoration(
                            hintText: 'Enter HTML here',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(
                  thickness: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Html(
                          config: htmlConfig,
                          renderMode: RenderMode.list,
                          data: _input,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'Please rotate your device to landscape mode.'
                'Or use a device with a larger screen.',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
