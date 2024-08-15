import 'package:flutter/material.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// Extension for `img` tag.
final class ImageExtension extends HtmlExtension {
  /// Creates a new instance of [ImageExtension].
  const ImageExtension();

  @override
  Set<String> get supportedTags => {'img'};

  Center _loader(ImageChunkEvent loadingProgress) {
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  Image _createImage(
    String src,
    String? alt,
    String? title,
    Style? style,
  ) {
    return Image.network(
      src,
      alignment: style?.alignment ?? Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        if (alt == null || alt.isEmpty) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Icon(Icons.error, color: Colors.red),
          );
        }

        return Text(alt);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return _loader(loadingProgress);
      },
    );
  }

  String? _getSrc(HTMLElement element, BuildContext context) {
    final hasSrcset = element.attributes.containsKey('srcset');
    final hasSrc = element.attributes.containsKey('src');
    if (!hasSrcset && !hasSrc) return null;
    if (hasSrcset) {
      try {
        final srcset = element.attributes['srcset']!;
        final srces = srcset.split(',').map((e) {
          final parts = e.trim().split(' ');
          return (
            src: parts.first,
            width: num.tryParse(parts.last.replaceAll('w', '')) ?? 0
          );
        }).toList();
        final deviceWidth = MediaQuery.sizeOf(context).width;
        final closestSrcToWidth = srces.reduce((a, b) {
          final aDiff = (a.width - deviceWidth).abs();
          final bDiff = (b.width - deviceWidth).abs();
          return aDiff < bDiff ? a : b;
        });
        return closestSrcToWidth.src;
      } catch (e) {
        return element.attributes['src']!;
      }
    }
    return element.attributes['src']!;
  }

  Widget _createWidget(
    Node node,
    HtmlConfig config,
    Style style,
    BuildContext context,
  ) {
    final element = node as HTMLElement;
    final src = _getSrc(element, context);
    if (src == null) return const SizedBox.shrink();
    final alt = element.attributes['alt'];
    final title = element.attributes['title'];
    return _createImage(src, alt, title, style);
  }

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    if (node is! HTMLElement) return null;
    final style =
        Style.fromElement(node, config).merge(config.styleOverrides['img']);
    return ParsedResult(
      source: node,
      builder: (context) => _createWidget(node, config, style, context),
      style: style,
    );
  }
}
