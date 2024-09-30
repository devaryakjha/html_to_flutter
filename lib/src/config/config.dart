// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:html_to_flutter/src/internals/internals.dart';
import 'package:meta/meta.dart';

/// {@template config}
///
/// This class represents all configurations for parsing HTML.
///
/// **Attributes**:
///
/// - `onTap`: The callback for tap event.
/// - `extensions`: List of [HtmlExtension] to be applied.
/// - `styleOverrides`: A map of style to be applied to the resulting widget.
/// - `gap`: The gap between the children of [Html].
///
/// {@endtemplate}
@immutable
class HtmlConfig {
  /// Creates a [HtmlConfig].
  ///
  /// {@macro config}
  const HtmlConfig({
    this.onTap,
    this.extensions = const [],
    this.styleOverrides = const {},
    this.gap = 0.0,
    this.baseFontSize = 16.0,
    this.defaultColor = const Color(0xFF000000),
  });

  /// This callback is invoked when a link is tapped.
  final OnLinkTap? onTap;

  /// List of extensions to be applied.
  final List<HtmlExtension> extensions;

  /// A map of style to be applied to the resulting widget.
  /// The `key` is the tag name and the `value` is an instance of [Style] class.
  /// This will override the default style extracted from the html.
  final Map<String, Style> styleOverrides;

  /// The gap between the children of [Html].
  ///
  /// - In case of [RenderMode.column],
  ///   this will be the space between the children.
  /// - In case of [RenderMode.list] and [RenderMode.sliver]
  ///   this will be the separator dimension.
  final double gap;

  /// The base font size.
  ///
  /// This property can be used to calculate the font size of the text,
  /// convert `rem` to `px` and `em` to `px`.
  final double baseFontSize;

  /// The default color.
  ///
  /// This property can be used to calculate the color of the text,
  /// border color, etc.
  final Color defaultColor;

  /// The list of built-in extensions.
  static const List<HtmlExtension> _builtInExtensions = [
    TextExtension(),
    FigureExtension(),
    ImageExtension(),
    HrExtension(),
    ListExtension(),
    ContainerExtension(),
  ];

  /// Returns [HtmlExtension] for the given [node] if supported.
  @internal
  HtmlExtension? getEffectiveExtensionForNode(Node node) {
    for (final extension in extensions) {
      if (extension.isNodeSupported(node)) {
        return extension;
      }
    }
    for (final extension in _builtInExtensions) {
      if (extension.isNodeSupported(node)) {
        return extension;
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HtmlConfig &&
          runtimeType == other.runtimeType &&
          onTap == other.onTap &&
          gap == other.gap &&
          baseFontSize == other.baseFontSize &&
          listEquals(extensions, other.extensions) &&
          mapEquals(styleOverrides, other.styleOverrides);

  @override
  int get hashCode => Object.hashAll(
        [
          onTap,
          extensions,
          styleOverrides,
          gap,
          _builtInExtensions,
          baseFontSize,
        ],
      );

  @override
  String toString() {
    return 'HtmlConfig('
        ' onTap: $onTap, extensions: $extensions,'
        ' styleOverrides: $styleOverrides'
        ' gap: $gap'
        ' builtInExtensions: ${_builtInExtensions.map((e) => e.runtimeType)}'
        ' baseFontSize: $baseFontSize'
        ' )';
  }

  HtmlConfig copyWith({
    OnLinkTap? onTap,
    List<HtmlExtension>? extensions,
    Map<String, Style>? styleOverrides,
    double? gap,
    double? baseFontSize,
    Color? defaultColor,
  }) {
    return HtmlConfig(
      onTap: onTap ?? this.onTap,
      extensions: extensions ?? this.extensions,
      styleOverrides: styleOverrides ?? this.styleOverrides,
      gap: gap ?? this.gap,
      baseFontSize: baseFontSize ?? this.baseFontSize,
      defaultColor: defaultColor ?? this.defaultColor,
    );
  }
}
