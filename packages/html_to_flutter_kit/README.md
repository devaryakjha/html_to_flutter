<a href="https://zerodha.tech"><img src="https://zerodha.tech/static/images/github-badge.svg" align="right" /></a>

# html_to_flutter_kit

[![pub package](https://img.shields.io/pub/v/html_to_flutter_kit.svg)](https://pub.dev/packages/html_to_flutter_kit)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/devaryakjha/html_to_flutter_kit/blob/master/LICENSE)

`html_to_flutter_kit` is a comprehensive Flutter package that bundles together all optional extensions from the `html_to_flutter` series. It allows developers to easily convert raw HTML strings into Flutter widgets, including complex tags like `<table/>` and `<iframe/>`.

## Features

- Convert basic HTML tags to Flutter widgets.
- Optionally support complex tags with additional extensions.
- Easy integration and usage.

## Usage

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

## Installation

Add `html_to_flutter_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  html_to_flutter_kit: ^0.0.1-dev.1
```

Then run `flutter pub get` to install the package.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/devaryakjha/html_to_flutter/tree/main/packages/html_to_flutter_kit/LICENSE) file for details.
