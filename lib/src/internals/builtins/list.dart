import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget that displays an unordered list.
final class ListExtension extends HtmlExtension {
  /// Creates a new instance of [ListExtension].
  const ListExtension();

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (node is! HTMLElement) return null;
    final tag = node.localName;
    final isOrdered = tag == 'ol';
    final style =
        Style.fromElement(node, config).merge(config.styleOverrides[tag]);
    return ParsedResult(
      builder: (context) {
        if (isOrdered) {
          return _OrderedList(style: style, node: node, config: config);
        }
        return _UnorderedList(style: style, node: node, config: config);
      },
      source: node,
      style: style,
    );
  }

  @override
  Set<String> get supportedTags => {'ul', 'ol'};
}

class _UnorderedList extends StatelessWidget {
  const _UnorderedList({
    required this.style,
    required this.node,
    required this.config,
  });

  final Style? style;

  final Node node;

  final HtmlConfig config;

  Widget _buildPrefix([TextStyle? textStyle]) {
    return Text('• ', style: textStyle);
  }

  @override
  Widget build(BuildContext context) {
    final items = node.nodes.whereType<HTMLElement>().toList();
    final parsedItems = items
        .map((e) => ParsedResult.fromNode(e, config))
        .whereNotNull()
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: style?.padding?.flatten ?? EdgeInsets.zero,
      itemCount: parsedItems.length,
      itemBuilder: (context, index) {
        final parsed = parsedItems[index];
        final child = parsed.call(context, config);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrefix(parsed.style.textStyle),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

class _OrderedList extends StatelessWidget {
  const _OrderedList({
    required this.style,
    required this.node,
    required this.config,
  });

  final Style? style;

  final Node node;

  final HtmlConfig config;

  Widget _buildPrefix(int index, [TextStyle? textStyle]) {
    return Text('${index + 1}. ', style: textStyle);
  }

  @override
  Widget build(BuildContext context) {
    final items = node.nodes.whereType<HTMLElement>().toList();
    final parsedItems = items
        .map((e) => ParsedResult.fromNode(e, config))
        .whereNotNull()
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: style?.padding?.flatten ?? EdgeInsets.zero,
      itemCount: parsedItems.length,
      itemBuilder: (context, index) {
        final parsed = parsedItems[index];
        final child = parsed.call(context, config);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrefix(index, parsed.style.textStyle),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
