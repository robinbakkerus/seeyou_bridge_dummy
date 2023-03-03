import 'package:seeyou_bridge_dummy/data/app_text.dart';
import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:seeyou_bridge_dummy/helper/settings_helper.dart';
import 'package:flutter/material.dart';

class BridgeSettings extends StatefulWidget {
  const BridgeSettings({super.key});

  @override
  State<BridgeSettings> createState() => _BridgeSettingsState();
}

class _BridgeSettingsState extends State<BridgeSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _selectLanguage(),
          Container(height: 40),
          _selectHeight(),
          Container(height: 40),
          _clearSettingButton(),
        ],
      ),
    ));
  }

  Widget _selectLanguage() {
    return _flags();
  }

  Widget _selectHeight() {
    String q = AppText.instance.getText(Tk.size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _question(q),
        Row(
          children: [
            _sizeSlider(),
            _sliderStatus(),
          ],
        ),
      ],
    );
  }

  Widget _flags() {
    String q = AppText.instance.getText(Tk.lang);

    return Row(
      children: [
        _question(q),
        _flag('nl'),
        _flag('en'),
        _flag('de'),
        _flag('es'),
        _flag('fr')
      ],
    );
  }

  Widget _question(String txt) {
    return Text(
      '  $txt : ',
      style: const TextStyle(
          height: 0.9,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }

  Widget _flag(String name) {
    String imageName = "assets/$name.jpg";
    bool showBox = name == PlayData.instance.language;

    return InkWell(
      child: Container(
          height: 100,
          width: 100,
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.all(1.0),
          decoration: showBox
              ? BoxDecoration(
                  border: Border.all(color: Colors.brown),
                )
              : null,
          child: Image(image: AssetImage(imageName))),
      onTap: () {
        setState(() {
          PlayData.instance.setLanguage(name);
        });
      },
    );
  }

  Widget _sizeSlider() {
    double val = PlayData.instance.showCardsCount.ceilToDouble();
    return SizedBox(
      width: 500,
      child: Slider(
          min: 5.0,
          max: 13.0,
          value: val,
          divisions: 8,
          label: '${val.round()}',
          onChanged: (value) {
            setState(() {
              PlayData.instance.setShowCardsCount(value.toInt());
            });
          }),
    );
  }

  Widget _sliderStatus() {
    String txt = PlayData.instance.showCardsCount.toString();
    return Text(
      txt,
      style: const TextStyle(
          height: 0.9,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }

  Widget _clearSettingButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      onPressed: () {
        setState(() {
          BridgeSettingsHelper.clearAllSetting();
        });
      },
      child: Text(AppText.instance.getText(Tk.reset)),
    );
  }
}
