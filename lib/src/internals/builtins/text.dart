import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget that displays a text.
final class TextExtension extends HtmlExtension {
  /// Creates a new instance of [TextExtension].
  const TextExtension();

  @override
  bool isNodeSupported(Node node) {
    return node is HTMLText || super.isNodeSupported(node);
  }

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (!isNodeSupported(node)) return null;

    if (node is HTMLText) {
      return _fromText(node, config);
    }

    if (node is HTMLElement) {
      return _fromElement(node, config);
    }

    return null;
  }

  ParsedResult? _fromText(HTMLText e, HtmlConfig config) {
    if (e.data.trim().isEmpty) return null;
    final style = config.styleOverrides['text'];
    return ParsedResult(
      builder: (context) {
        var input = e.data;
        if (input.startsWith('\n')) {
          input = input.substring(1);
        }
        return Text(
          input,
          style: style?.textStyle,
        );
      },
      source: e,
      style: style,
    );
  }

  ParsedResult? _fromElement(HTMLElement e, HtmlConfig config) {
    final style =
        Style.fromElement(e, config).merge(config.styleOverrides[e.localName]);
    return ParsedResult(
      builder: (context) {
        final spans = e.nodes
            .map((node) {
              final isEmpty = node.text?.trim().isEmpty ?? false;
              if (isEmpty) {
                if (node is HTMLText) {
                  return null;
                }
              }
              return _createSpanForNodeRecurssively(node, config, context);
            })
            .whereNotNull()
            .toList();

        return Text.rich(
          TextSpan(children: spans),
          style: style.textStyle,
        );
      },
      source: e,
      style: style,
    );
  }

  InlineSpan? _createSpanForNodeRecurssively(
    Node node,
    HtmlConfig config,
    BuildContext context,
  ) {
    if (!isNodeSupported(node)) {
      final result = ParsedResult.fromNode(node, config);
      if (result == null) return null;
      final widget = result(context, config);
      return WidgetSpan(
        child: widget,
        style: result.style.textStyle,
      );
    }

    if (node is HTMLText) {
      return TextSpan(text: node.text);
    }

    if (node is HTMLElement) {
      return _createSpanForElement(node, config, context);
    }

    return null;
  }

  InlineSpan _createSpanForElement(
    HTMLElement e,
    HtmlConfig config,
    BuildContext context,
  ) {
    if (e.localName == 'br') return const TextSpan(text: '\n');
    final children = e.nodes
        .map((node) => _createSpanForNodeRecurssively(node, config, context))
        .whereNotNull()
        .toList();
    final style =
        Style.fromElement(e, config).merge(config.styleOverrides[e.localName]);
    return TextSpan(
      children: children,
      style: style.textStyle,
    );
  }

  @override
  Set<String> get supportedTags => {
        'text',
        'a',
        'p',
        'h1',
        'h2',
        'h3',
        'h4',
        'h5',
        'h6',
        'span',
        'sup',
        'sub',
        'b',
        'strong',
        'i',
        'em',
        'br',
        'tr',
        'td',
        'th',
        'tbody',
        'thead',
        'li',
        'u',
        'strike',
      };
}
