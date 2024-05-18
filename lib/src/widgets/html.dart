import 'package:flutter/material.dart';
import 'package:simple_html_to_flutter/src/utils/parser.dart';

class Html extends StatefulWidget {
  const Html({required this.data, super.key});

  final String data;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  late final HtmlParser _parser;

  @override
  void initState() {
    super.initState();
    _parser = HtmlParser(data: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text.rich(_parser.parse()),
    );
  }
}
