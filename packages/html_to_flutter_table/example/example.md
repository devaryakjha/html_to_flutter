```dart
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter_table/html_to_flutter_table.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTML to Flutter Table Demo'),
        ),
        body: Html(
          data: """
            <div>
              <h1>Sample Table</h1>
              <table>
                <tr>
                  <th>Header 1</th>
                  <th>Header 2</th>
                  <th>Header 3</th>
                </tr>
                <tr>
                  <td>Data 1</td>
                  <td colspan="2">Data 2 with colspan</td>
                </tr>
                <tr>
                  <td rowspan="2">Data 3 with rowspan</td>
                  <td>Data 4</td>
                  <td>Data 5</td>
                </tr>
                <tr>
                  <td>Data 6</td>
                  <td>Data 7</td>
                </tr>
              </table>
            </div>
          """,
          extensions: const [
            TableExtension(),
          ],
        ),
      ),
    );
  }
}
```
