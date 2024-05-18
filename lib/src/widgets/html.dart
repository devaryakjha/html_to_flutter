import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// {@template html}
/// A widget to display HTML content.
/// {@endtemplate}
class Html extends StatefulWidget {
  /// {@macro html}
  const Html({
    required this.data,
    super.key,
    this.config = const HtmlConfig.defaults(),
  });

  /// The HTML data to display.
  final String data;

  /// The configuration for the HTML widget.
  final HtmlConfig config;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  late HtmlParser _parser;

  @override
  void initState() {
    super.initState();
    _parser = HtmlParser(data: widget.data, config: widget.config);
  }

  @override
  void didUpdateWidget(covariant Html oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data || oldWidget.config != widget.config) {
      _parser = HtmlParser(data: widget.data, config: widget.config);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(_parser.parse());
  }
}
