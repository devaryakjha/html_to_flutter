# html_to_flutter

[![pub package](https://img.shields.io/pub/v/html_to_flutter.svg)](https://pub.dev/packages/html_to_flutter)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/devaryakjha/html_to_flutter/blob/master/LICENSE)

A flutter package to help convert raw html string to flutter widgets.

Take the following code as an example

```dart
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
```

It will render as following

<img  src="https://raw.githubusercontent.com/devaryakjha/html_to_flutter/master/screenshots/readme_example.png" />
