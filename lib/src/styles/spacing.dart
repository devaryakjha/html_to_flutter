import 'package:flutter/widgets.dart';
import 'package:html_to_flutter/html_to_flutter.dart';

/// {@template spacing}
/// This class represents properties like `margin`, `padding`, etc.
/// {@endtemplate}
@immutable
final class Spacing {
  /// Creates a [Spacing].
  const Spacing({
    required this.bottom,
    required this.left,
    required this.right,
    required this.top,
  });

  /// Creates a [Spacing] with all units set to [SpacingValueUnit.px].
  Spacing.px({
    double bottom = 0,
    double left = 0,
    double right = 0,
    double top = 0,
  }) : this(
          bottom: Value(bottom),
          left: Value(left),
          right: Value(right),
          top: Value(top),
        );

  const Spacing._only({
    this.bottom = Value.zero,
    this.left = Value.zero,
    this.right = Value.zero,
    this.top = Value.zero,
  });

  /// Creates a [Spacing] with symmetric values.
  const Spacing.symmetric({
    Value? vertical,
    Value? horizontal,
  }) : this._only(
          bottom: vertical ?? Value.zero,
          left: horizontal ?? Value.zero,
          right: horizontal ?? Value.zero,
          top: vertical ?? Value.zero,
        );

  /// Creates a [Spacing] with the same value for all sides.
  const Spacing._all(Value value)
      : this.symmetric(vertical: value, horizontal: value);

  /// Creates a [Spacing] from a CSS string.
  factory Spacing.fromCssString(String input, HtmlConfig config) {
    final parts = input.split(' ').map((e) => e.trim()).toList();
    if (parts.length == 1) {
      final value = _fromString(parts[0], config.baseFontSize);
      if (value != null) return Spacing._all(value);
    } else if (parts.length == 2) {
      final vertical = _fromString(parts[0], config.baseFontSize);
      final horizontal = _fromString(parts[1], config.baseFontSize);
      if (vertical != null && horizontal != null) {
        return Spacing.symmetric(vertical: vertical, horizontal: horizontal);
      }
    } else if (parts.length == 3) {
      final top = _fromString(parts[0], config.baseFontSize);
      final horizontal = _fromString(parts[1], config.baseFontSize);
      final bottom = _fromString(parts[2], config.baseFontSize);
      if (top != null && horizontal != null && bottom != null) {
        return Spacing(
          bottom: bottom,
          left: horizontal,
          right: horizontal,
          top: top,
        );
      }
    } else if (parts.length == 4) {
      final top = _fromString(parts[0], config.baseFontSize);
      final right = _fromString(parts[1], config.baseFontSize);
      final bottom = _fromString(parts[2], config.baseFontSize);
      final left = _fromString(parts[3], config.baseFontSize);
      if (top != null && right != null && bottom != null && left != null) {
        return Spacing(
          bottom: bottom,
          left: left,
          right: right,
          top: top,
        );
      }
    }
    return Spacing.zero;
  }

  static Value? _fromString(String? input, double baseFontSize) {
    final isPercentage = input?.endsWith('%') ?? false;
    if (isPercentage) return null;

    final unit = input?.endsWith('px') ?? false
        ? SpacingValueUnit.px
        : SpacingValueUnit.rem;
    final cleanedInput = input?.replaceAll(RegExp('[a-z%]'), '');
    final value = double.tryParse(cleanedInput ?? '');
    if (value == null) return null;
    return Value(value, unit, baseFontSize);
  }

  /// The [EdgeInsets] representation.
  EdgeInsets get flatten => EdgeInsets.only(
        bottom: bottom.flatten,
        left: left.flatten,
        right: right.flatten,
        top: top.flatten,
      );

  /// The bottom side value.
  final Value bottom;

  /// The left side value.
  final Value left;

  /// The right side value.
  final Value right;

  /// The top side value.
  final Value top;

  /// The default spacing.
  static const Spacing zero = Spacing._all(Value.zero);

  @override
  String toString() {
    return 'Spacing{top: $top,  right: $right, bottom: $bottom, left: $left}';
  }
}

/// {@template spacing.value}
/// This class represents a spacing value.
/// {@endtemplate}
@immutable
final class Value {
  /// Creates a [Value].
  const Value(
    this.value, [
    this.unit = SpacingValueUnit.px,
    this.remMultiplier = 16.0,
  ]);

  /// The actual value.
  final double value;

  /// The unit of the value.
  final SpacingValueUnit unit;

  /// Multiplier for `rem` unit.
  final double remMultiplier;

  /// flatten [value] to pixels.
  ///
  /// If [unit] is [SpacingValueUnit.px], returns [value].
  /// If [unit] is [SpacingValueUnit.rem], returns [value] * [remMultiplier].
  double get flatten {
    return switch (unit) {
      SpacingValueUnit.px => value,
      SpacingValueUnit.rem => value * remMultiplier,
    };
  }

  @override
  String toString() {
    return 'Value{value: $value, unit: $unit, remMultiplier: $remMultiplier}';
  }

  /// The zero value.
  static const Value zero = Value(0);
}

/// The unit of a spacing value.
enum SpacingValueUnit {
  /// The value is in pixels.
  px,

  /// The value is in `em` or `rem`.
  rem;
}
