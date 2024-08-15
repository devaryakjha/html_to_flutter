import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// A widget that displays a horizontal line.
final class HrExtension extends HtmlExtension {
  /// Creates a new instance of [HrExtension].
  const HrExtension();

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    final style = config.styleOverrides['hr']
        ?.merge(node is HTMLElement ? Style.fromElement(node, config) : null);
    return ParsedResult(
      builder: (context) => Divider(
        thickness: 2,
        height: 1,
        color: style?.color ?? DefaultTextStyle.of(context).style.color,
      ),
      source: node,
    );
  }

  @override
  Set<String> get supportedTags => {'hr'};
}
