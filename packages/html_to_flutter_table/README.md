# html_to_flutter_table

Extension to the `html_to_flutter` package to support rendering `<table>` tag.

Under the hood this package uses [`flutter_layout_grid`](https://pub.dev/packages/flutter_layout_grid) plugin for rendering the table and achieve near css like UI

It also respects `rowspan` and `colspan` values if provided in the attributes of the element.

Example Usage:

```dart
Widget html = Html(
    data: """
    ....Some html containing table
    """,
    extensions: const [
        TableExtension(),
    ]
);
```
