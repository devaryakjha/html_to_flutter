import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart';

/// {@template parser}
/// A utility class to parse HTML content.
/// {@endtemplate}
final class HtmlParser {
  /// {@macro parser}
  const HtmlParser({
    required this.data,
    this.config = const HtmlConfig.defaults(),
  });

  /// The HTML data to parse.
  final String data;

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  /// Parses the HTML data and returns a [TextSpan].
  InlineSpan parse() {
    final parsed = parser.parse(data);
    final body = parsed.body;
    final bodyNodes = body?.nodes;
    var children = <InlineSpan>[];
    if (bodyNodes != null) {
      children = _parseNodes(bodyNodes);
    }
    return TextSpan(children: children);
  }

  List<InlineSpan> _parseNodes(List<dom.Node> nodes) {
    final spans = <InlineSpan>[];
    for (final node in nodes) {
      if (node is dom.Element) {
        spans.add(_parseElement(node));
      } else if (node is dom.Text) {
        final isAnchor = node.parent?.localName == 'a';
        spans.add(
          TextSpan(
            text: node.text,
            recognizer: isAnchor
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    config.onAnchorClick?.call(
                      Uri.parse(node.parent?.attributes['href'] ?? ''),
                    );
                  })
                : null,
          ),
        );
      }
    }
    return spans;
  }

  InlineSpan _parseElement(dom.Node node) {
    final element = node as dom.Element;
    final children = _parseNodes(element.nodes);
    return switch (element.localName) {
      'img' => WidgetSpan(
          child: Image.network(
            element.attributes['src']!,
            semanticLabel: element.attributes['alt'] ?? '',
            width: element.attributes['width'] != null
                ? double.tryParse(element.attributes['width'] ?? '')
                : null,
            height: element.attributes['height'] != null
                ? double.tryParse(element.attributes['height'] ?? '')
                : null,
          ),
        ),
      _ when ['b', 'strong', 'i', 'em', 'u', 'a'].contains(element.localName) =>
        TextSpan(
          children: children,
          style: config.getStyle(element.localName),
        ),
      'br' => const TextSpan(text: '\n'),
      _ => TextSpan(children: children),
    };
  }
}
