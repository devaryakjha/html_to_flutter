import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';
import 'package:meta/meta.dart';

@internal
abstract final class HtmlList extends StatelessWidget {
  factory HtmlList({
    required List<Widget> children,
    required HtmlConfig config,
    required EdgeInsets padding,
    required RenderMode renderMode,
    Key? key,
  }) {
    return switch (renderMode) {
      RenderMode.list => _HtmlList.new,
      RenderMode.column => _HtmlColumn.new,
      RenderMode.sliver => _HtmlSliverList.new,
    }(
      config: config,
      padding: padding,
      key: key,
      children: children,
    );
  }

  const HtmlList._({
    required this.children,
    required this.config,
    required this.padding,
    super.key,
  });

  final List<Widget> children;

  final HtmlConfig config;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context);
}

final class _HtmlColumn extends HtmlList {
  const _HtmlColumn({
    required super.children,
    required super.config,
    required super.padding,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

final class _HtmlList extends HtmlList {
  const _HtmlList({
    required super.children,
    required super.config,
    required super.padding,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      itemBuilder: (context, index) => children[index],
      itemCount: children.length,
      separatorBuilder: (context, index) => SizedBox(height: config.gap),
    );
  }
}

final class _HtmlSliverList extends HtmlList {
  const _HtmlSliverList({
    required super.children,
    required super.config,
    required super.padding,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.separated(
        itemBuilder: (context, index) => children[index],
        itemCount: children.length,
        separatorBuilder: (context, index) => SizedBox(height: config.gap),
      ),
    );
  }
}
