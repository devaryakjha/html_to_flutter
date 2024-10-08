import 'package:example/zerodha_custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter_kit/html_to_flutter_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';

final htmlConfig = HtmlConfig(
  onTap: (url, [attributes, element]) {
    if (url == null) return;
    launchUrlString(url);
  },
  extensions: [
    const TableExtension(),
    const IframeExtextion(),
    TagExtension(
      supportedTags: const {'zerodha'},
      builder: (context) => const CustomPaint(
        size: Size(100, 100),
        foregroundPainter: ZerodhaLogo(),
      ),
    ),
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
      margin: Spacing.px(top: 16, bottom: 20),
      textStyle: const TextStyle(fontSize: 16),
    ),
    'ul': Style(
      margin: Spacing.px(top: 16, bottom: 10),
      padding: Spacing.px(left: 20),
    ),
    'ol': Style(
      margin: Spacing.px(top: 16, bottom: 10),
      padding: Spacing.px(left: 20),
    ),
  },
);

const defaultInput = """
          <div>
              <h1>Hello, Flutter!</h1>
              <p>This is a sample HTML content converted to Flutter widgets.</p>
              <p>It supports <strong>bold</strong>, <em>italic</em>, <u>underline</u>, <strike>strike</strike>, and <a href="https://flutter.dev">links</a>.</p>
              <p>It supports unordered lists:</p>
              <ul>
                <li color="#ff0000">Hex color</li>
                <li color="hsl(0, 100%, 50%)">HSL color</li>
                <li color="rgb(255,0,0)">RGB color</li>
              </ul>
             <p>and ordered lists:</p>
              <ol>
                <li>Item 1</li>
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
              <p>It supports custom tags:</p>
              <zerodha></zerodha>
              <p>It supports iframes:</p>
              <iframe src="https://zerodha.tech/projects" width="100%" height="300" />
            </div>""";
