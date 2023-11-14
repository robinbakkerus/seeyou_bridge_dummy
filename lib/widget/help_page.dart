import 'package:flutter/material.dart';
import 'package:seeyou_bridge_dummy/data/app_text.dart';

class BridgeHelpPage extends StatelessWidget {
  BridgeHelpPage({super.key});

  final String _help1 = AppText.instance.getText(Tk.help1);
  final String _help2 = AppText.instance.getText(Tk.help2);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_help1),
                const SelectableText(
                  'https://youtu.be/uwc0c0Js6t8',
                  style: TextStyle(color: Colors.blue),
                ),
                Container(
                  height: 50,
                ),
                Text(_help2),
                const Image(image: AssetImage('assets/help_appbar.jpg')),
              ],
            )));
  }
}
