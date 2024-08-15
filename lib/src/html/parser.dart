import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart';

/// Parse HTML string to [Document].
///
/// Alias for `package:html/parser.dart` [parser.parse].
///
/// ```dart
/// import 'package:html_to_flutter/html_to_flutter.dart';
///
/// void main() {
///  final doc = parseHtml('<div>Hello <strong>world</strong>!</div>');
///  print(doc.outerHtml);
/// }
/// ```
///
Document parseHtml(String html) {
  return parser.parse(html);
}
