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
    this.onImageClick,
    this.builders,
  }) : styles = styles ??
            (defaultStyle == null
                ? const HtmlStyles()
                : HtmlStyles.fromDefaultTextStyle(defaultStyle));

  /// The default configuration for the HTML widget.
  const HtmlConfig.defaults()
      : styles = const HtmlStyles(),
        defaultStyle = null,
        onImageClick = null,
        onAnchorClick = null,
        builders = null;

  /// The map of text styles for each tag.
  final HtmlStyles styles;

  /// The callback for when an anchor is clicked.
  final OnAnchorClick? onAnchorClick;

  /// The callback for when an image is clicked.
  final OnImageClick? onImageClick;

  /// The default text style.
  /// If provided, this style will be applied to all text.
  final TextStyle? defaultStyle;

  /// Returns the [TextStyle] for the given tag.
  TextStyle getStyle(String? tag) => styles.getStyle(tag);

  /// The widget builders for each tag.
  final WidgetBuilders? builders;
}

/// {@template html_styles.widget}
/// A map of widget builders for each tag.
/// {@endtemplate}
final class WidgetBuilders {
  /// {@macro html_styles.widget}
  const WidgetBuilders({
    this.image,
  });

  /// The builder for the image tag.
  final Widget Function(
    String src, {
    String? alt,
    Size? size,
  })? image;
}
