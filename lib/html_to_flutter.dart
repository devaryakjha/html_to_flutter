/// Core implementation for `Html`.
///
/// This package exposes `Html` entrypoint to parse HTML content and convert it
/// to Flutter widgets.
///
/// It is a set of bare minimum classes and interfaces to parse HTML content
/// that supports rudimentary HTML tags and attributes.
///
/// It is designed to be extended by other packages to provide more features.
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:html_to_flutter/html_to_flutter.dart';
///
/// void main() {
///  runApp(
///   const MaterialApp(
///       home: Scaffold(
///         body: Html(data: '<h1>Hello World</h1>'),
///       ),
///     ),
///   );
/// }
/// ```
library html_to_flutter;

export 'src/config/config.dart';
export 'src/config/render_node.dart';
export 'src/extension.dart';
export 'src/html/html.dart';
export 'src/html_to_flutter.dart';
export 'src/parsed_result.dart';
export 'src/style.dart';
export 'src/styles/styles.dart';
export 'src/typedefs.dart';
export 'src/utils/utils.dart';
