import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart' hide HTMLText;
import 'package:html_to_flutter/src/internals/render/html_renderer.dart';
import 'package:html_to_flutter/src/parser.dart';

/// {@template style}
///
/// The entrypoint for this package.
///
/// The `Html` widgets takes HTML string as input
/// and converts it to an Flutter widgets.
///
/// **Attributes**:
///
/// - `data`: The HTML content to parse.
/// - `config`: The configuration for parsing HTML.
/// - `padding`: The amount of space by which to inset the children.
///
/// {@endtemplate}
class Html extends StatefulWidget {
  /// Creates a [Html] widget.
  /// {@macro style}
  const Html({
    required this.data,
    this.config = const HtmlConfig(),
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.renderMode = RenderMode.column,
  });

  /// The HTML content to parse.
  final String data;

  /// Configuration for parsing HTML.
  final HtmlConfig config;

  /// The amount of space by which to inset the children.
  final EdgeInsets padding;

  /// Defines how the children of [Html] should be rendered.
  ///
  /// default is [RenderMode.column]
  final RenderMode renderMode;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  HtmlConfig get config => widget.config;

  String get data => widget.data;

  List<ParsedResult> _parsed = [];

  FutureOr<void> _parse() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _parsed = Parser(config: config).parse(data);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _parse();
  }

  @override
  void didUpdateWidget(Html oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != data || oldWidget.config != config) {
      _parse();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('data', data))
      ..add(DiagnosticsProperty<HtmlConfig>('config', config))
      ..add(DiagnosticsProperty<EdgeInsets>('padding', widget.padding))
      ..add(DiagnosticsProperty<RenderMode>('renderMode', widget.renderMode))
      ..add(
        DiagnosticsProperty<Set<Node>>(
          'sources',
          _parsed.map((e) => e.source).toSet(),
        ),
      );
  }

  List<Widget> _prepareWiget(ParsedResult result) {
    final widget = result(context, config);
    if (widget is KeyedSubtree) {
      final child = widget.child;
      if (child is SizedBox && child.child == null) {
        return result.children.map(_prepareWiget).expand((e) => e).toList();
      }
      return [widget];
    }
    return [widget];
  }

  @override
  Widget build(BuildContext context) {
    return HtmlList(
      renderMode: widget.renderMode,
      key: ObjectKey(data),
      padding: widget.padding,
      config: config,
      children: _parsed.map(_prepareWiget).expand((e) => e).toList(),
    );
  }
}
