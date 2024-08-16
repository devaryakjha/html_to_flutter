/// A parser that parses CSS color values.
///
/// possible formats:
/// - `#RRGGBB`
/// - `#AARRGGBB`
/// - `rgb(r, g, b)`
/// - `rgba(r, g, b, a)`
/// - `hsl(h, s%, l%)`
/// - `hsla(h, s%, l%, a)`
/// - `color_name`
library css_color_parser;

import 'package:flutter/material.dart';
import 'package:html_to_flutter/src/utils/css_color_names.dart';

/// A parser that parses CSS color values.
final class CssColorParser {
  /// Creates a new instance of [CssColorParser].
  const CssColorParser(this.input);

  /// Provided input to parse.
  final String input;

  /// Parse the given CSS color and change it to a Flutter color.
  ///
  /// Supported formats:
  /// - `#RRGGBB`
  /// - `#AARRGGBB`
  /// - `rgb(r, g, b)`
  /// - `rgba(r, g, b, a)`
  /// - `hsl(h, s%, l%)`
  /// - `hsla(h, s%, l%, a)`
  /// - `color_name`
  Color? parse() {
    if (input.startsWith('#')) {
      return _parseHex(input);
    }

    if (input.startsWith('rgb')) {
      return _parseRgb(input);
    }

    if (input.startsWith('hsl')) {
      return _parseHsl(input);
    }

    return _parseColorName(input);
  }

  Color? _parseRgb(String input) {
    final match = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)').firstMatch(input);
    if (match == null) return null;

    final r = int.parse(match.group(1)!);
    final g = int.parse(match.group(2)!);
    final b = int.parse(match.group(3)!);
    return Color.fromARGB(255, r, g, b);
  }

  Color? _parseHsl(String input) {
    final match = RegExp(r'hsl\((\d+),\s*(\d+)%,\s*(\d+)%\)').firstMatch(input);
    if (match == null) return null;

    final h = int.parse(match.group(1)!);
    final s = int.parse(match.group(2)!);
    final l = int.parse(match.group(3)!);
    return HSLColor.fromAHSL(1, h / 360, s / 100, l / 100).toColor();
  }

  Color? _parseHex(String input) {
    final hex = input.substring(1);
    if (hex.length == 3) {
      final r = int.parse('${hex[0]}${hex[0]}', radix: 16);
      final g = int.parse('${hex[1]}${hex[1]}', radix: 16);
      final b = int.parse('${hex[2]}${hex[2]}', radix: 16);
      return Color.fromARGB(255, r, g, b);
    }

    if (hex.length == 6) {
      final r = int.parse(hex.substring(0, 2), radix: 16);
      final g = int.parse(hex.substring(2, 4), radix: 16);
      final b = int.parse(hex.substring(4, 6), radix: 16);
      return Color.fromARGB(255, r, g, b);
    }

    if (hex.length == 8) {
      final a = int.parse(hex.substring(0, 2), radix: 16);
      final r = int.parse(hex.substring(2, 4), radix: 16);
      final g = int.parse(hex.substring(4, 6), radix: 16);
      final b = int.parse(hex.substring(6, 8), radix: 16);
      return Color.fromARGB(a, r, g, b);
    }

    return null;
  }

  Color? _parseColorName(String input) {
    final hexValue = cssColorNameMap[input];
    return hexValue != null ? _parseHex(hexValue) : null;
  }
}
