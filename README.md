<a href="https://zerodha.tech"><img src="https://zerodha.tech/static/images/github-badge.svg" align="right" /></a>

# html_to_flutter

[![pub package](https://img.shields.io/pub/v/html_to_flutter.svg)](https://pub.dev/packages/html_to_flutter)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/devaryakjha/html_to_flutter/blob/master/LICENSE)

`html_to_flutter` is a Flutter package that converts raw HTML strings into Flutter widgets. It supports various HTML tags and can be extended with additional packages for complex tags like tables and iframes.

## Live Preview

You can see a live preview of the `html_to_flutter` package in action at [https://aryakdev.vercel.app/flutter/html_to_flutter](https://aryakdev.vercel.app/flutter/html_to_flutter). This demo showcases the capabilities of the package and its extensions.

## Features

- Convert HTML elements to Flutter widgets.
- Support for text formatting (bold, italic, underline, strike).
- Support for links, lists, images, and tables.
- Extensible with additional packages for more complex HTML elements.

## Installation

Add `html_to_flutter` to your `pubspec.yaml`:

```yaml
dependencies:
  html_to_flutter: ^1.0.0
```

Then run `flutter pub get` to install the package.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter_table/html_to_flutter_table.dart'; // Example extension

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTML to Flutter Demo'),
        ),
        body: Html(
          config: HtmlConfig(
            onTap: (url, [attributes, element]) {
              log('Tapped on $url');
              log('Attributes: $attributes');
              log('Element: $element');
            },
            extensions: [
              const TableExtension(),
            ],
          ),
          renderMode: RenderMode.list,
          data: """
            <div>
              <h1>Hello, Flutter!</h1>
              <p>This is a sample HTML content converted to Flutter widgets.</p>
              <p>It supports <strong>bold</strong>, <em>italic</em>, <u>underline</u>, <strike>strike</strike>, and <a href="https://flutter.dev">links</a>.</p>
              <p>It supports ordered and unordered lists:</p>
              <ul>
                <li>Item 1</li>
                <li>Item 2</li>
                <li>Item 3</li>
              </ul>
              <ol>
                <li>Item 1</li>
                <li>Item 2</li>
                <li>Item 3</li>
              </ol>
              <p>It supports images:</p>
              <span>
                <img src="https://via.placeholder.com/100" height="100" />
                <img src="https://via.placeholder.com/100" height="100" />
                <img src="https://via.placeholder.com/100" height="100" />
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
            </div>
          """,
        ),
      ),
    );
  }
```

## Screenshot

The following is an example of how the rendered UI will look:

<img src="https://raw.githubusercontent.com/devaryakjha/html_to_flutter/main/screenshots/readme_example.png" width="250" />

## Extensibiliy

The `html_to_flutter` package can be extended with the following sub-packages for additional functionality:

- html_to_flutter_table  
   [![pub package](https://img.shields.io/pub/v/html_to_flutter_table.svg)](https://pub.dev/packages/html_to_flutter_table)  
  Supports rendering HTML tables, including `colspan` and `rowspan`.

- html_to_flutter_iframe  
  [![pub package](https://img.shields.io/pub/v/html_to_flutter_iframe.svg)](https://pub.dev/packages/html_to_flutter_iframe)  
  Supports rendering HTML iframes using the `flutter_inappwebview` package.

- html_to_flutter_kit  
  [![pub package](https://img.shields.io/pub/v/html_to_flutter_kit.svg)](https://pub.dev/packages/html_to_flutter_kit)  
  Bundles all the available sub-packages for ease of use.

## 🚧 Work in Progress

Please note that the `html_to_flutter` package and its sub-packages are currently a work in progress. As such, you might encounter bugs or incomplete features. We welcome your feedback and contributions to help improve these packages. If you find any issues or have suggestions, please report them on the respective GitHub repositories.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/devaryakjha/html_to_flutter/blob/master/LICENSE) file for details.
