import 'package:html_to_flutter/html_to_flutter.dart';

/// Helper for [Node] extensions.
extension ValidElementExtension on List<Node> {
  /// Gets valid elements.
  List<HTMLElement> get validElements => whereType<HTMLElement>().toList();
}
