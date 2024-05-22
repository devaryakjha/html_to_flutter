import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter/src/utils/unescape_string.dart';

/// {@template parser}
/// A utility class to parse HTML content.
/// {@endtemplate}
final class HtmlParser {
  /// {@macro parser}
  HtmlParser({
    this.config = const HtmlConfig.defaults(),
  });

  /// The HTML data to parse.
  late final String data;

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
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is dom.Element) {
        spans.add(_parseElement(node));
      } else if (node is dom.Text) {
        spans.add(_createSpanForTextNode(node, i, nodes));
      }
    }
    return spans;
  }

  InlineSpan _createSpanForTextNode(
    dom.Text node,
    int index,
    List<dom.Node> nodes,
  ) {
    final tagName = node.parent?.localName ?? '';
    if (tagName == 'li') {
      return _createListSpan(node, index, nodes);
    } else {
      if (node.text.trim().isEmpty && (tagName == 'ol' || tagName == 'ul')) {
        return const TextSpan(text: '');
      }
    }
    final isAnchor = tagName == 'a';
    return TextSpan(
      text: _parseText(node.text, tagName, index, nodes),
      recognizer: isAnchor
          ? (TapGestureRecognizer()
            ..onTap = () {
              config.onAnchorClick?.call(
                Uri.parse(node.parent?.attributes['href'] ?? ''),
              );
            })
          : null,
    );
  }

  InlineSpan _createListSpan(
    dom.Text node,
    int index,
    List<dom.Node> nodes,
  ) {
    final liParent = node.parent!;
    final listType = liParent.parent?.localName;
    final isOrdered = listType == 'ol';
    final liPrefix = isOrdered
        // ignore: lines_longer_than_80_chars
        ? '${(liParent.parent?.nodes.where((node) => node.text?.trim().isNotEmpty ?? false).toList().indexOf(liParent) ?? 0) + 1}.'
        : '•';
    return WidgetSpan(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(liPrefix),
            const SizedBox(width: 8),
            Expanded(child: Text(_parseText(node.text, 'li', index, nodes))),
          ],
        ),
      ),
    );
  }

  String _parseText(
    String text,
    String localName,
    int index,
    List<dom.Node> nodes,
  ) {
    return switch (localName) {
      'p' when index == (nodes.length - 1) => '$text\n',
      'li' => text,
      'br' => '\n',
      _ => text,
    };
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
      _ => TextSpan(
          children: children,
          style: config.getStyle(element.localName),
        ),
    };
  }

  /// Prepares the HTML data for parsing.
  void prepare(String input, {bool avoidEscaping = false}) {
    if (avoidEscaping) {
      data = input;
      return;
    }

    final tempData = unescape(input);

    data = tempData
      ..replaceAll(RegExp('<p>'), '<span>')
      ..replaceAll(RegExp('</p>'), '</span>')
      ..replaceAll(RegExp(r'(<p.*>.*)(<img.*\/>)(<\/p>)*'), r'$2')
      ..replaceAll(RegExp(r'(<span.*>)(<img.*\/>)(<\/span>)*'), r'$2')
      ..replaceAll(RegExp('<span><img'), '<img')
      ..replaceAll(RegExp('<img'), '</span></span><img')
      ..replaceAll(RegExp('<ol>'), '<span><ol>')
      ..replaceAll(RegExp('<ul>'), '<span><ul>')
      ..replaceAll(RegExp('<p><ol>'), '<ol>')
      ..replaceAll(RegExp('<p><li>'), '<li>')
      ..replaceAll(RegExp('</p></li>'), '</li>')
      ..replaceAll(RegExp('</p></ol>'), '</ol>')
      ..replaceAll(RegExp(r'(\r\n\r|\r\n\r\n|\n\n|\r\r|\r\n|\r\n\t)'), '');
  }
}
