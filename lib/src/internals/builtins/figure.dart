import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget that displays a figure.
final class FigureExtension extends HtmlExtension {
  /// Creates a new instance of [FigureExtension].
  const FigureExtension();

  @override
  Set<String> get supportedTags => {'figure'};

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (!isNodeSupported(node)) return null;
    final children = node.nodes
        .map((e) => ParsedResult.fromNode(e, config))
        .whereNotNull()
        .toList();
    return ParsedResult(
      style: Style.fromElement(node as HTMLElement, config)
          .merge(config.styleOverrides['figure']),
      children: children,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((e) => e(context, config)).toList(),
      ),
      source: node,
    );
  }
}
