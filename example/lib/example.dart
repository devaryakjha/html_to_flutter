import 'package:example/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:html_to_flutter_kit/html_to_flutter_kit.dart';

import 'constants.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  String _input = defaultInput;
  late final Debouncer<String> debouncer;

  @override
  void initState() {
    super.initState();
    debouncer = Debouncer(
      duration: const Duration(milliseconds: 500),
      onValue: (String input) {
        _input = input;
        if (mounted) setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Enter HTML content below:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          initialValue: _input,
                          onChanged: debouncer.call,
                          maxLines: 1000,
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(thickness: 5),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Html(
                          config: htmlConfig,
                          renderMode: RenderMode.list,
                          data: _input,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                'Please rotate your device to landscape mode.'
                'Or use a device with a larger screen.',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
