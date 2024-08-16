import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:nanoid/nanoid.dart';

/// {@template parsed_result}
/// `ParsedResult` represents the result of parsing HTML.
///
/// **Attributes**:
///
/// - `style`: Style to be applied to the resulting widget.
/// - `builder`: builder function for the resulting widget.
///
/// {@endtemplate}
// Helps standardize the output of parsing HTML.
@immutable
final class ParsedResult {
  /// Creates a [ParsedResult].
  ///
  /// {@macro parsed_result}
  ParsedResult({
    required WidgetBuilder builder,
    required this.source,
    this.children = const [],
    Style? style,
  })  : style = style ?? const Style(),
        _widgetKey = ValueKey(nanoid()),
        _builder = builder;

  /// Creates a [ParsedResult] from a [node].
  static ParsedResult? fromNode(Node node, HtmlConfig config) {
    final extension = config.getEffectiveExtensionForNode(node);
    if (extension == null) return null;
    return extension.parseNode(node, config);
  }

  /// Style to be applied to the resulting widget.
  final Style style;

  /// builder function for the resulting widget.
  final WidgetBuilder _builder;

  /// An array of children.
  ///
  /// for example, a [ParsedResult] for a `table`
  /// tag will have children for `thead`, `tbody`, and `tfoot`.
  final List<ParsedResult> children;

  /// The source from which the [_builder] was created.
  final Node source;

  /// The key for the widget.
  ///
  /// Can be supplied to the widget returned by [_builder].
  final Key? _widgetKey;

  Widget _wrapInPaddingIfChildValid(Widget child) {
    if (style.margin != null && child is! SizedBox) {
      return Padding(
        padding: style.margin!.flatten,
        child: child,
      );
    }
    return child;
  }

  /// Redirects to [_builder].
  Widget call(BuildContext context, HtmlConfig config) {
    return KeyedSubtree(
      key: _widgetKey,
      child: _wrapInPaddingIfChildValid(_builder(context)),
    );
  }
}
