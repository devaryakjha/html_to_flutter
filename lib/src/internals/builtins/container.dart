import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// Extension for container tags.
///
/// supported tags: `container`, `div`
///
final class ContainerExtension extends HtmlExtension {
  /// Creates an instance of [ContainerExtension].
  const ContainerExtension();

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (node is! HTMLElement) return null;
    final children = node.nodes
        .map((node) => ParsedResult.fromNode(node, config))
        .whereNotNull()
        .toList();
    return ParsedResult(
      children: children,
      builder: (context) => const SizedBox.shrink(),
      source: node,
      style: config.styleOverrides[node.localName]
          ?.merge(Style.fromElement(node, config)),
    );
  }

  @override
  Set<String> get supportedTags => {
        'container',
        'div',
      };
}
