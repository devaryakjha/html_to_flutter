import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

const Map<String, TextStyle> _defaultTextStyleMap = {
  'b': TextStyle(fontWeight: FontWeight.bold),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'i': TextStyle(fontStyle: FontStyle.italic),
  'em': TextStyle(fontStyle: FontStyle.italic),
  'u': TextStyle(decoration: TextDecoration.underline),
  'strike': TextStyle(decoration: TextDecoration.lineThrough),
  'a': TextStyle(
    decoration: TextDecoration.underline,
    color: Color(0xFF0077cc),
    decorationColor: Color(0xFF0077cc),
  ),
  'th': TextStyle(fontWeight: FontWeight.bold),
};

/// {@template style}
/// This class represents all supported CSS properties by this package.
///
/// **Attributes**:
///
/// - `margin`: The margin property.
/// - `padding`: The padding property.
/// - `textStyle`: The text style applied to the text.
///
/// {@endtemplate}
@immutable
final class Style {
  /// Creates a [Style].
  ///
  /// {@macro style}
  const Style({
    this.margin,
    this.padding,
    TextStyle? textStyle,
    this.alignment,
    this.width,
    this.height,
    Color? color,
    this.textWrap = false,
  })  : _textStyle = textStyle,
        _color = color;

  /// Creates a [Style] from an element.
  factory Style.fromElement(HTMLElement element, HtmlConfig config) {
    return Style(
      margin: _parseSpacing(
        _getAttributeValue(element.attributes, 'margin'),
        config,
      ),
      padding: _parseSpacing(
        _getAttributeValue(element.attributes, 'padding'),
        config,
      ),
      textStyle: _defaultTextStyleMap[element.localName],
      alignment:
          _parseAlignment(_getAttributeValue(element.attributes, 'align')),
      width: _parseDouble(_getAttributeValue(element.attributes, 'width')),
      height: _parseDouble(_getAttributeValue(element.attributes, 'height')),
      color: _parseCssColor(_getAttributeValue(element.attributes, 'color')),
    );
  }

  static String? _getAttributeValue(
    LinkedHashMap<Object, String> attributes,
    String key,
  ) {
    if (attributes.containsKey(key)) return attributes[key];
    final smallKey = key.toLowerCase();
    if (attributes.containsKey(key)) return attributes[smallKey];
    final styles = attributes['style'];
    if (styles == null) return null;
    final style = styles.split(';').firstWhereOrNull((s) {
      final parts = s.split(':');
      return parts.first.trim().toLowerCase() == key;
    });
    if (style == null) return null;
    return style.split(':').last.trim();
  }

  /// Parse the given CSS color and change it to a Flutter color.
  ///
  /// possible formats:
  /// - `#RRGGBB`
  /// - `#AARRGGBB`
  /// - `rgb(r, g, b)`
  /// - `rgba(r, g, b, a)`
  /// - `hsl(h, s%, l%)`
  /// - `hsla(h, s%, l%, a)`
  /// - `color_name`
  static Color? _parseCssColor(String? input) {
    if (input == null) return null;
    return CssColorParser(input).parse();
  }

  static double? _parseDouble(String? input) {
    if (input == null) return null;
    return num.tryParse(input)?.toDouble();
  }

  static Spacing? _parseSpacing(String? input, HtmlConfig config) {
    if (input == null) return null;
    return Spacing.fromCssString(input, config);
  }

  static Alignment? _parseAlignment(String? input) {
    if (input == null) return null;
    return switch (input) {
      'left' => Alignment.centerLeft,
      'right' => Alignment.centerRight,
      'center' => Alignment.center,
      _ => null,
    };
  }

  /// The margin property.
  final Spacing? margin;

  /// The padding property.
  final Spacing? padding;

  /// The text style.
  final TextStyle? _textStyle;

  final Color? _color;

  /// Alignment for the widget.
  ///
  /// Can be used to align the widget inside a parent widget.
  final Alignment? alignment;

  /// Width for the widget.
  final double? width;

  /// Height for the widget.
  final double? height;

  /// Wether the underlying text should wrap.
  final bool textWrap;

  /// Text style for the widget.
  TextStyle? get textStyle {
    return _color != null
        ? (_textStyle ?? const TextStyle()).copyWith(
            color: _color,
            decorationColor: _color,
          )
        : _textStyle;
  }

  /// Color for the widget.
  Color? get color => _color;

  /// Merges this style with another.
  Style merge(Style? other) {
    if (other == null) return this;
    return Style(
      margin: other.margin ?? margin,
      padding: other.padding ?? padding,
      textStyle: other.textStyle?.merge(textStyle),
      color: other.color ?? color,
      alignment: other.alignment ?? alignment,
      width: other.width ?? width,
      height: other.height ?? height,
    );
  }
}
