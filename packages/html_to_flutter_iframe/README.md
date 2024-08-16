# html_to_flutter_iframe

[![pub package](https://img.shields.io/pub/v/html_to_flutter_iframe.svg)](https://pub.dev/packages/html_to_flutter_iframe)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/devaryakjha/html_to_flutter_iframe/blob/master/LICENSE)

`html_to_flutter_iframe` is a Flutter package that uses the `flutter_inappwebview` package to render iframes within Flutter applications. This extension package works with the `html_to_flutter` parent package.

## Features

- Convert HTML iframe elements to Flutter widgets.
- Render iframes using `flutter_inappwebview`.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter_iframe/html_to_flutter_iframe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTML to Flutter Iframe Demo'),
        ),
        body: Html(
          data: """
            <div>
              <h1>Sample Iframe</h1>
              <iframe src="https://www.example.com" width="600" height="400"></iframe>
            </div>
          """,
          extensions: const [
            IframeExtension(),
          ],
        ),
      ),
    );
  }
}
```

## Installation

Add `html_to_flutter` and `html_to_flutter_iframe` to your `pubspec.yaml`:

```yaml
dependencies:
  html_to_flutter: ^1.0.0
  html_to_flutter_iframe: ^1.0.0
```

Then run `flutter pub get` to install the packages.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/devaryakjha/html_to_flutter_iframe/blob/master/LICENSE) file for details.
