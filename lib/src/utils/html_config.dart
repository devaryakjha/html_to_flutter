// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  /// Return configuration of the nearest [HtmlConfig] ancestor.
  static HtmlConfig? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GlobalHtmlConfig>()
        ?.config;
  }

  /// Return configuration of the nearest [HtmlConfig] ancestor.
  static HtmlConfig of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  int get hashCode => Object.hashAll([
        styles,
        onAnchorClick,
        onImageClick,
        defaultStyle,
        builders,
      ]);

  @override
  bool operator ==(Object other) =>
      other is HtmlConfig &&
      other.styles == styles &&
      other.onAnchorClick == onAnchorClick &&
      other.onImageClick == onImageClick &&
      other.defaultStyle == defaultStyle &&
      other.builders == builders;

  HtmlConfig copyWith({
    HtmlStyles? styles,
    OnAnchorClick? onAnchorClick,
    OnImageClick? onImageClick,
    TextStyle? defaultStyle,
    WidgetBuilders? builders,
  }) {
    return HtmlConfig(
      styles: styles ?? this.styles,
      onAnchorClick: onAnchorClick ?? this.onAnchorClick,
      onImageClick: onImageClick ?? this.onImageClick,
      defaultStyle: defaultStyle ?? this.defaultStyle,
      builders: builders ?? this.builders,
    );
  }

  HtmlConfig merge(HtmlConfig other) {
    return copyWith(
      styles: styles.merge(other.styles),
      onAnchorClick: other.onAnchorClick,
      onImageClick: other.onImageClick,
      defaultStyle: other.defaultStyle,
      builders: other.builders,
    );
  }
}

/// {@template html_styles.widget}
/// A map of widget builders for each tag.
/// {@endtemplate}
final class WidgetBuilders {
  /// {@macro html_styles.widget}
  const WidgetBuilders({
    this.image,
    this.text,
  });

  /// The builder for the image tag.
  final Widget Function(
    String src, {
    String? alt,
    Size? size,
  })? image;

  /// The builder for the text tags (p, span, etc.).
  final Widget Function(String text)? text;
}

/// {@template html_styles}
/// A way to declare HtmlConfig for all the child Html widgets.
/// {@endtemplate}
final class GlobalHtmlConfig extends InheritedModel<HtmlConfig> {
  /// Creates a new [GlobalHtmlConfig] widget.
  const GlobalHtmlConfig({
    required this.config,
    required super.child,
    super.key,
  });

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  @override
  bool updateShouldNotify(covariant GlobalHtmlConfig oldWidget) {
    return oldWidget.config != config;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant GlobalHtmlConfig oldWidget,
    Set<HtmlConfig> dependencies,
  ) {
    return dependencies.any((config) => oldWidget.config != config);
  }
}
