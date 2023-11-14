import 'package:flutter/material.dart';
import 'package:seeyou_bridge_dummy/data/app_text.dart';

class BridgeAbout extends StatefulWidget {
  const BridgeAbout({super.key});

  @override
  State<BridgeAbout> createState() => _BridgeAboutState();
}

class _BridgeAboutState extends State<BridgeAbout> {
  final String _content = AppText.instance.getText(Tk.about);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_content, style: const TextStyle(fontSize: 20)),
        const SelectableText('geleidehond.nl/steun-ons',
            style: TextStyle(fontSize: 24, color: Colors.blue)),
        Container(
          height: 20,
        ),
        const Text('The web based version of SeeYouBridgeDummy:'),
        const SelectableText(
          'seeyoubridgedummy.web.app',
          style: TextStyle(fontSize: 24, color: Colors.blue),
        ),
      ],
    );
  }
}
