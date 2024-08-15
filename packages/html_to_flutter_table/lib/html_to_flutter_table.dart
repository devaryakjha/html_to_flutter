/// This library is endorsement of the package `widgets_from_html_core`.
///
/// It provides a `TableExtension` class to help building table widgets.
// ignore_for_file: avoid_print
library html_to_flutter_table;

import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:html_to_flutter/html_to_flutter.dart'
    show
        HTMLElement,
        HtmlConfig,
        HtmlExtension,
        Node,
        ParsedResult,
        Style,
        ValidElementExtension;

/// Extension for table widgets.
final class TableExtension extends HtmlExtension {
  /// Creates an instance of [TableExtension].
  const TableExtension();

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (node is! HTMLElement) return null;
    return ParsedResult(
      builder: (context) => _HtmlTable(element: node, config: config),
      source: node,
      style: config.styleOverrides[node.localName]
          ?.merge(Style.fromElement(node, config)),
    );
  }

  @override
  Set<String> get supportedTags => {'table'};
}

class _HtmlTable extends StatefulWidget {
  const _HtmlTable({
    required this.element,
    required this.config,
  });

  final HTMLElement element;

  final HtmlConfig config;

  @override
  State<_HtmlTable> createState() => _HtmlTableState();
}

class _HtmlTableState extends State<_HtmlTable> {
  HtmlConfig get config => widget.config;

  List<Widget> children = [];
  List<TrackSize> columnSizes = [];
  List<TrackSize> rowSizes = [];

  void _createColumnSizes(int maxColumns) {
    columnSizes = List.generate(
      maxColumns,
      (index) => 200.px,
    );
  }

  void _createRowSizes(int maxRows) {
    rowSizes = List.generate(
      maxRows,
      (index) => auto,
    );
  }

  void _createContentForJustTrs(HTMLElement tbody) {
    final allNodes = tbody.nodes.validElements.toList();
    final allTrs = allNodes.where((e) => e.localName == 'tr').toList();
    _createColumnSizes(
      allTrs.fold<int>(
        0,
        (previousValue, element) => math.max(
          element.nodes.validElements.length,
          previousValue,
        ),
      ),
    );
    _createRowSizes(allTrs.length);
    _createChildren(allTrs);
    setState(() {});
  }

  void _createContentForTbodyAndTHead(HTMLElement tbody, HTMLElement thead) {
    final allThs = thead.getElementsByTagName('tr').firstOrNull;
    final allNodes = tbody.nodes.validElements.toList();
    final allTrs = [
      allThs,
      ...allNodes.where((e) => e.localName == 'tr'),
    ].whereNotNull().toList();
    final allTds = allTrs
        .map(
          (e) => e.nodes.validElements
              .where((e) => ['td', 'th'].contains(e.localName)),
        )
        .expand((e) => e)
        .toList();
    _createColumnSizes(
      allThs != null
          ? math.max(
              allThs.nodes.validElements.length,
              allTds.length,
            )
          : allTds.length,
    );
    _createRowSizes(allTrs.length);
    _createChildren(allTrs);
    setState(() {});
  }

  void _createContent() {
    final element = widget.element;
    final allNodes = element.nodes.validElements;
    if (allNodes.isEmpty) {
      return;
    }
    if (allNodes.every((e) => e.localName == 'tr')) {
      _createContentForJustTrs(element);
      return;
    }
    final thead = allNodes.firstWhereOrNull((e) => e.localName == 'thead');
    final tbody = allNodes.firstWhereOrNull((e) => e.localName == 'tbody');
    if (thead == null) {
      _createContentForJustTrs(tbody!);
      return;
    }
    _createContentForTbodyAndTHead(tbody!, thead);
  }

  void _createChildren(List<HTMLElement> allTrs) {
    children = allTrs.indexed
        .map((record) {
          final index = record.$1;
          final tr = record.$2;
          final allTds = tr.nodes.validElements
              .where((e) => ['td', 'th'].contains(e.localName));
          return allTds.map(
            (td) {
              final rowspan = int.tryParse(td.attributes['rowspan'] ?? '');
              final colspan = int.tryParse(td.attributes['colspan'] ?? '');
              return ParsedResult.fromNode(td, config)
                  ?.call(context, config)
                  .withBorder(config.defaultColor)
                  .withGridPlacement(
                    rowStart: index,
                    rowSpan: rowspan ?? 1,
                    columnSpan: colspan ?? 1,
                  );
            },
          );
        })
        .expand((e) => e)
        .whereNotNull()
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _createContent();
  }

  @override
  void didUpdateWidget(covariant _HtmlTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.element != oldWidget.element) {
      _createContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (columnSizes.isEmpty || children.isEmpty) {
      return const SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        children: children,
      ),
    );
  }
}

extension on Widget {
  Widget withBorder([Color? color]) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color ?? Colors.black),
        ),
        child: this,
      );
}
