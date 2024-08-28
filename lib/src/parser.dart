import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:html_to_flutter/html_to_flutter.dart'
    show HTMLElement, HtmlConfig, NodeList, ParsedResult, parseHtml, HTMLText;
import 'package:meta/meta.dart';

/// Parser for HTML content.
@immutable
@visibleForTesting
final class Parser {
  /// Creates a [Parser].
  const Parser({
    required this.config,
  });

  /// The config for parsing HTML.
  final HtmlConfig config;

  /// Parses the HTML content.
  List<ParsedResult> parse(String data) {
    final nodes = _toNodeList(data);

    /// If None, return an empty list.
    if (nodes == null) return [];

    final result = nodes
        .where((node) =>
            node is HTMLElement || (node is HTMLText && node.text.isNotEmpty))
        .map((node) => ParsedResult.fromNode(node, config))
        .whereNotNull()
        .toList();

    return result;
  }

  /// Parses the String `data` and returns a [NodeList].
  NodeList? _toNodeList(String data) {
    final document = parseHtml(data);
    return document.body?.nodes;
  }
}
