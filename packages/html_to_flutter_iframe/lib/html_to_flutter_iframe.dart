/// This library is endorsement of the package `html_to_flutter`.
///
/// It provides a `IframeExtension` class to help building iframe widgets.
library html_to_flutter_iframe;

import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// An extension to parse iframe tags.
///
/// This extension uses the `flutter_inappwebview` package to render iframes.
final class IframeExtextion extends HtmlExtension {
  /// Creates a new instance of [IframeExtextion].
  const IframeExtextion();

  @override
  ParsedResult? parseNode(Node node, HtmlConfig config) {
    final src = node.attributes['src'];
    if (src == null) return null;
    final style = Style.fromElement(node as HTMLElement, config)
        .merge(config.styleOverrides['iframe']);
    return ParsedResult(
      builder: (context) {
        final aspectRatio = style.width != null && style.height != null
            ? style.width! / style.height!
            : 16 / 9;
        return AspectRatio(
          aspectRatio: aspectRatio,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(src)),
            initialSettings: InAppWebViewSettings(
              transparentBackground: true,
              underPageBackgroundColor: const Color(0xfff5f5f7),
              iframeAllowFullscreen: false,
              isElementFullscreenEnabled: false,
            ),
          ),
        );
      },
      source: node,
    );
  }

  @override
  Set<String> get supportedTags => {'iframe'};
}
