import 'package:flutter/material.dart';

/// {@template html_styles}
/// The default text styles for each HTML tag.
/// {@endtemplate}
@immutable
final class HtmlStyles {
  /// {@macro html_styles}
  const HtmlStyles({
    this.p = const TextStyle(),
    this.b = const TextStyle(fontWeight: FontWeight.bold),
    this.i = const TextStyle(fontStyle: FontStyle.italic),
    this.u = const TextStyle(decoration: TextDecoration.underline),
    this.a = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    this.h1 = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    this.h2 = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    this.h3 = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    this.h4 = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    this.h5 = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.h6 = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.customTagToStyle = const <String, TextStyle>{},
  });

  /// The default text styles for each HTML tag.
  factory HtmlStyles.fromDefaultTextStyle(TextStyle style) {
    return HtmlStyles(
      p: style,
      b: style.copyWith(fontWeight: FontWeight.bold),
      i: style.copyWith(fontStyle: FontStyle.italic),
      u: style.copyWith(decoration: TextDecoration.underline),
      a: style.copyWith(
        color: Colors.blue,
        decoration: TextDecoration.underline,
        decorationColor: Colors.blue,
      ),
      h1: style.copyWith(fontWeight: FontWeight.bold),
      h2: style.copyWith(fontWeight: FontWeight.bold),
      h3: style.copyWith(fontWeight: FontWeight.bold),
      h4: style.copyWith(fontWeight: FontWeight.bold),
      h5: style.copyWith(fontWeight: FontWeight.bold),
      h6: style.copyWith(fontWeight: FontWeight.bold),
    );
  }

  /// The text style for the `<p>` tag.
  final TextStyle p;

  /// The text style for the `<b>` and `<strong>` tag.
  final TextStyle b;

  /// The text style for the `<i>` and `<em> tag.
  final TextStyle i;

  /// The text style for the `<u>` tag.
  final TextStyle u;

  /// The text style for the `<a>` tag.
  final TextStyle a;

  /// The text style for the `<h1>` tag.
  final TextStyle h1;

  /// The text style for the `<h2>` tag.
  final TextStyle h2;

  /// The text style for the `<h3>` tag.
  final TextStyle h3;

  /// The text style for the `<h4>` tag.
  final TextStyle h4;

  /// The text style for the `<h5>` tag.
  final TextStyle h5;

  /// The text style for the `<h6>` tag.
  final TextStyle h6;

  /// The map of custom tags to text styles.
  final Map<String, TextStyle> customTagToStyle;

  /// Returns the [TextStyle] for the given tag.
  TextStyle getStyle(String? tag) {
    if (customTagToStyle.containsKey(tag)) {
      return customTagToStyle[tag]!;
    }

    return switch (tag) {
      'p' => p,
      'b' || 'strong' => b,
      'i' || 'em' => i,
      'u' => u,
      'a' => a,
      'h1' => h1,
      'h2' => h2,
      'h3' => h3,
      'h4' => h4,
      'h5' => h5,
      'h6' => h6,
      _ => const TextStyle(),
    };
  }
}
