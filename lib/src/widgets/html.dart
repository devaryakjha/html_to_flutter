import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.avoidEscaping = false,
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

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app
  /// with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned
  /// as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// If this is null [TextStyle.overflow] will be used, otherwise the value
  /// from the nearest [DefaultTextStyle] ancestor will be used.
  final TextOverflow? overflow;

  /// {@macro flutter.painting.textPainter.textScaler}
  final TextScaler? textScaler;

  /// An optional maximum number of lines for the text to span,
  /// wrapping if necessary.
  /// If the text exceeds the given number of lines,
  /// it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// {@template flutter.widgets.Text.semanticsLabel}
  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text.
  /// This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// const Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  /// {@endtemplate}
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  /// The color to use when painting the selection.
  ///
  /// This is ignored if [SelectionContainer.maybeOf] returns null
  /// in the [BuildContext] of the [Text] widget.
  ///
  /// If null, the ambient [DefaultSelectionStyle] is used (if any); failing
  /// that, the selection color defaults to [DefaultSelectionStyle.defaultColor]
  /// (semi-transparent grey).
  final Color? selectionColor;

  /// Whether to avoid escaping HTML entities.
  final bool avoidEscaping;

  @override
  State<Html> createState() => _HtmlState();
}

class _HtmlState extends State<Html> {
  late HtmlParser _parser;

  @override
  void initState() {
    super.initState();
    _parser = HtmlParser(config: widget.config)
      ..prepare(
        widget.data,
        avoidEscaping: widget.avoidEscaping,
      );
  }

  @override
  void didUpdateWidget(covariant Html oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data ||
        oldWidget.config != widget.config ||
        oldWidget.defaultStyle != widget.defaultStyle ||
        oldWidget.color != widget.color ||
        widget.avoidEscaping != oldWidget.avoidEscaping) {
      _parser = HtmlParser(config: widget.config)
        ..prepare(
          widget.data,
          avoidEscaping: widget.avoidEscaping,
        );
      setState(() {});
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      StringProperty(
        'data',
        widget.data,
        style: DiagnosticsTreeStyle.transition,
      ),
    );
    super.debugFillProperties(properties);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style:
            (widget.defaultStyle ?? (const DefaultTextStyle.fallback().style))
                .apply(
          color: widget.color,
        ),
        maxLines: widget.maxLines,
        overflow: widget.overflow ?? TextOverflow.clip,
        textAlign: widget.textAlign ?? TextAlign.start,
        softWrap: widget.softWrap ?? true,
        child: Text.rich(
          _parser.parse(),
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          locale: widget.locale,
          softWrap: widget.softWrap,
          overflow: widget.overflow,
          textWidthBasis: widget.textWidthBasis,
          maxLines: widget.maxLines,
          strutStyle: widget.strutStyle,
          textHeightBehavior: widget.textHeightBehavior,
          selectionColor: widget.selectionColor,
          textScaler: TextScaler.noScaling,
        ),
      ),
    );
  }
}
