import 'package:html_to_flutter/html_to_flutter.dart';

/// Signature for tap event handler.
typedef OnLinkTap = void Function(
  String? url, [
  Map<String, String>? attributes,
  HTMLElement? element,
]);
