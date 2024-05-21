import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// {@template html}
/// A widget to display HTML content.
/// {@endtemplate}
class Html extends StatefulWidget {
  /// {@macro html}
  Html({
    required this.data,
    super.key,
    this.defaultStyle,
    HtmlConfig? config,
    this.color,
  }) : config = config ??
            (defaultStyle == null
                ? const HtmlConfig.defaults()
                : HtmlConfig(defaultStyle: defaultStyle));

  /// The HTML data to display.
  final String data;

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  /// The default text style.
  final TextStyle? defaultStyle;

  /// The color of the text.
  final Color? color;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  late HtmlParser _parser;

  @override
  void initState() {
    super.initState();
    _parser = HtmlParser(config: widget.config)..prepare(widget.data);
  }

  @override
  void didUpdateWidget(covariant Html oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data ||
        oldWidget.config != widget.config ||
        oldWidget.defaultStyle != widget.defaultStyle ||
        oldWidget.color != widget.color) {
      _parser = HtmlParser(config: widget.config)..prepare(widget.data);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: DefaultTextStyle(
        style:
            (widget.defaultStyle ?? (const DefaultTextStyle.fallback().style))
                .apply(
          color: widget.color,
        ),
        child: Text.rich(_parser.parse()),
      ),
    );
  }
}
