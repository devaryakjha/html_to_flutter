```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets_from_html/widgets_from_html.dart' hide HTMLText;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleFonts.pendingFonts([
    GoogleFonts.sourceSerif4TextTheme(),
    GoogleFonts.interTextTheme(),
  ]);
  runApp(MaterialApp(
    home: const WidgetsFromHtmlExample(),
  ));
}

class WidgetsFromHtmlExample extends StatefulWidget {
  const WidgetsFromHtmlExample({super.key});

  @override
  State<WidgetsFromHtmlExample> createState() => _WidgetsFromHtmlExampleState();
}

class _WidgetsFromHtmlExampleState extends State<WidgetsFromHtmlExample> {
  TextStyle _createHeadingStyle(TextStyle? textStyle) {
    return GoogleFonts.getFont(
      'Source Serif 4',
      textStyle: textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Widgets from HTML Example',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        elevation: 10,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Scaffold(
        appBar: AppBar(
          title: Text('HTML to Flutter Demo'),
        ),
        body: Html(
          data: """
            <div>
                <h1>Hello, Flutter!</h1>
                  <p>This is a sample HTML content converted to Flutter widgets.</p>
                  <p>It supports <strong>bold</strong>, <em>italic</em>, <u>underline</u>, <strike>strike</strike> and <a href="https://flutter.dev">links</a>.</p>
                  <p>It supports ordered and unordered lists</p>
                  <ul>
                    <li>Item 1</li>
                    <li>Item 2</li>
                    <li>Item 3</li>
                  </ul>
                  <br />
                  <ol>
                    <li>Item 1</li>
                    <li>Item 2</li>
                    <li>Item 3</li>
                  </ol>
                  <p>It supports images</p>
                  <span><img src="https://via.assets.so/movie.png?id=1&q=95&w=100&h=100&fit=fill" height="100" /><img src="https://via.assets.so/movie.png?id=2&q=95&w=100&h=100&fit=fill" height="100" /><img src="https://via.assets.so/movie.png?id=3&q=95&w=100&h=100&fit=fill" height="100" /></span>
                  <p>It supports tables</p>
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
                </div>
          """,
        ),
      ),
    );
  }
}

```
