# html_to_flutter_table

[![pub package](https://img.shields.io/pub/v/html_to_flutter_table.svg)](https://pub.dev/packages/html_to_flutter_table)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/devaryakjha/html_to_flutter/tree/main/packages/html_to_flutter_table/LICENSE)

An extension package for [`html_to_flutter`](https://pub.dev/packages/html_to_flutter) to add support for `<table>` tag.

`html_to_flutter_table` is a Flutter package that leverages the `flutter_layout_grid` package to render HTML tables. It supports basic tables as well as advanced features like `colspan` and `rowspan`.

## Features

- Convert HTML table elements to Flutter widgets.
- Support for `colspan` and `rowspan` attributes.
- Utilizes `flutter_layout_grid` for flexible table layouts.

## Usage

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

## Installation

Add `html_to_flutter_table` to your `pubspec.yaml`:

```yaml
dependencies:
  html_to_flutter_table: ^latest_version
```

Then run `flutter pub get` to install the package.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/devaryakjha/html_to_flutter/tree/main/packages/html_to_flutter_table/LICENSE) file for details.
