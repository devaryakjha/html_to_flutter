import 'package:flutter/material.dart';

const _kDefaultMap = <String, TextStyle>{
  'p': TextStyle(),
  'b': TextStyle(fontWeight: FontWeight.bold),
  'strong': TextStyle(fontWeight: FontWeight.bold),
  'em': TextStyle(fontStyle: FontStyle.italic),
  'i': TextStyle(fontStyle: FontStyle.italic),
  'u': TextStyle(decoration: TextDecoration.underline),
  'a': TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
    decorationColor: Colors.blue,
  ),
  'h1': TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  'h2': TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  'h3': TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  'h4': TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  'h5': TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  'h6': TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
};

@immutable

/// {@template html_config}
/// Configuration for the HTML widget.
/// {@endtemplate}
final class HtmlConfig {
  /// {@macro html_config}
  const HtmlConfig({
    required this.textStyles,
  });

  /// The default configuration for the HTML widget.
  const HtmlConfig.defaults() : textStyles = _kDefaultMap;

  /// The map of text styles for each tag.
  final Map<String, TextStyle> textStyles;

  /// Returns the [TextStyle] for the given tag.
  TextStyle getStyle(String? tag) => textStyles[tag] ?? const TextStyle();
}
