import 'package:flutter/material.dart';
import 'package:simple_html_to_flutter/simple_html_to_flutter.dart';

/// {@template html_config}
/// Configuration for the HTML widget.
/// {@endtemplate}
@immutable
final class HtmlConfig {
  /// {@macro html_config}
  const HtmlConfig({
    this.styles = const HtmlStyles(),
    this.onAnchorClick,
  });

  /// The default configuration for the HTML widget.
  const HtmlConfig.defaults()
      : styles = const HtmlStyles(),
        onAnchorClick = null;

  /// The map of text styles for each tag.
  final HtmlStyles styles;

  /// The callback for when an anchor is clicked.
  final OnAnchorClick? onAnchorClick;

  /// Returns the [TextStyle] for the given tag.
  TextStyle getStyle(String? tag) => styles.getStyle(tag);
}
