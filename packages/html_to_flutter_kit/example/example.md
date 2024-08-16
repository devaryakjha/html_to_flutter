```dart
import 'package:flutter/material.dart';
import 'package:html_to_flutter_kit/html_to_flutter_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTML to Flutter Kit Demo'),
        ),
        body: Html(
          data: """
            <div>
              <h1>Hello, Flutter!</h1>
              <p>This is a sample HTML content converted to Flutter widgets.</p>
              <table>
                <tr>
                  <th>Header 1</th>
                  <th>Header 2</th>
                </tr>
                <tr>
                  <td>Data 1</td>
                  <td>Data 2</td>
                </tr>
              </table>
              <iframe src="https://www.example.com"></iframe>
            </div>
          """,
        ),
      ),
    );
  }
}
```
