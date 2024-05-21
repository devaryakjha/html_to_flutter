import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// {@template html_config}
/// Configuration for the HTML widget.
/// {@endtemplate}
@immutable
final class HtmlConfig {
  /// {@macro html_config}
  HtmlConfig({
    HtmlStyles? styles,
    this.defaultStyle,
    this.onAnchorClick,
  }) : styles = styles ??
            (defaultStyle == null
                ? const HtmlStyles()
                : HtmlStyles.fromDefaultTextStyle(defaultStyle));

  /// The default configuration for the HTML widget.
  const HtmlConfig.defaults()
      : styles = const HtmlStyles(),
        defaultStyle = null,
        onAnchorClick = null;

  /// The map of text styles for each tag.
  final HtmlStyles styles;

  /// The callback for when an anchor is clicked.
  final OnAnchorClick? onAnchorClick;

  /// The default text style.
  /// If provided, this style will be applied to all text.
  final TextStyle? defaultStyle;

  /// Returns the [TextStyle] for the given tag.
  TextStyle getStyle(String? tag) => styles.getStyle(tag);
}
