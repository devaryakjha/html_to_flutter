import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
          softWrap: style?.textWrap,
        );
      },
      source: e,
      style: style,
    );
  }

  ParsedResult? _fromElement(HTMLElement e, HtmlConfig config) {
    final style =
        Style.fromElement(e, config).merge(config.styleOverrides[e.localName]);
    final spansEmpty = e.nodes.every((node) {
          final isEmpty = node.text?.trim().isEmpty ?? false;
          return isEmpty && node is HTMLText;
        }) &&
        !['td'].contains(e.localName);
    if (spansEmpty) return null;
    return ParsedResult(
      builder: (context) {
        final spans = e.nodes
            .map((node) {
              final isEmpty = node.text?.trim().isEmpty ?? false;
              if (isEmpty && node is HTMLText) return null;
              return _createSpanForNodeRecurssively(node, config, context);
            })
            .whereNotNull()
            .toList();

        final combined = TextSpan(
          children: spans,
          style: style.textStyle,
        );

        if (combined.toPlainText().trim().isEmpty) {
          return const SizedBox.shrink();
        }

        return Text.rich(
          combined,
          softWrap: style.textWrap,
        );
      },
      source: e,
      style: style,
    );
  }

  InlineSpan? _createSpanForNodeRecurssively(
    Node node,
    HtmlConfig config,
    BuildContext context, [
    GestureRecognizer? recognizer,
  ]) {
    if (!isNodeSupported(node)) {
      final result = ParsedResult.fromNode(node, config);
      if (result == null) return null;
      final widget = result(context, config);
      return WidgetSpan(
        child: recognizer is TapGestureRecognizer
            ? GestureDetector(
                onTap: recognizer.onTap,
                child: widget,
              )
            : widget,
        style: result.style.textStyle,
      );
    }

    if (node is HTMLText) {
      return TextSpan(
        text: node.text,
        recognizer: recognizer,
      );
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
    GestureRecognizer? recognizer;
    if (e.localName == 'br') return const TextSpan(text: '\n');
    if (e.localName == 'a' && e.attributes['href'] != null) {
      recognizer = TapGestureRecognizer()
        ..onTap = () {
          config.onTap?.call(
            e.attributes['href'],
            {...e.attributes},
            e,
          );
        };
    }
    final children = e.nodes
        .map(
          (node) {
            return _createSpanForNodeRecurssively(
              node,
              config,
              context,
              recognizer,
            );
          },
        )
        .whereNotNull()
        .toList();
    final style =
        Style.fromElement(e, config).merge(config.styleOverrides[e.localName]);
    return TextSpan(
      children: children,
      style: style.textStyle,
      recognizer: children.isEmpty ? recognizer : null,
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
