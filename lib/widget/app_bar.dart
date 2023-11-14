import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:seeyou_bridge_dummy/event/app_events.dart';
import 'package:flutter/material.dart';
import 'package:seeyou_bridge_dummy/widget/about.dart';

class BridgeAppBar {
  static AppBar buildAppBar(BuildContext context) {
    return AppBar(
        leading: _showAboutAction(context),
        titleSpacing: 0,
        actions: <Widget>[
          _actions(),
        ]);
  }

  static Widget _actions() {
    double w = _actionsWidth();

    return SizedBox(
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _showHomeAction(),
          _showPlayAction(),
          _resetAction(),
          _showSettingsAction(),
          _showHelpAction(),
        ],
      ),
    );
  }

  static double _actionsWidth() {
    double w = PlayData.instance.screenWidth * 0.8;
    if (w < 0) {
      w = 500;
    }
    return w;
  }

  static Padding _showHomeAction() => _showAction(_firePlay, Icons.home);
  static Padding _showPlayAction() =>
      _showAction(_fireSelect, Icons.app_registration);
  static Padding _showHelpAction() => _showAction(_fireHelp, Icons.help);
  static Padding _showSettingsAction() =>
      _showAction(_fireSettings, Icons.settings_applications);

  static void _firePlay() => AppEvents.fireShowPage(ShowPage.play);
  static void _fireSelect() => AppEvents.fireShowPage(ShowPage.select);
  static void _fireHelp() => AppEvents.fireShowPage(ShowPage.help);
  static void _fireSettings() => AppEvents.fireShowPage(ShowPage.settings);

  static Widget _showAboutAction(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            showAboutDialog(
              context: context,
              // applicationIcon: Icon()

              applicationName: 'See you Bridge dummy',
              applicationVersion: 'version: 2.1',
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 50, 2),
                    child: BridgeAbout())
              ],
            );
          },
          child: const Icon(
            Icons.menu,
            size: 40.0,
          ),
        ));
  }

  static Padding _resetAction() {
    return _showAction(_doReset, Icons.cached);
  }

  static void _doReset() {
    PlayData.instance.reset();
    AppEvents.fireReset();
  }

  static Padding _showAction(void Function() func, IconData? iconData) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            func();
          },
          child: Icon(
            iconData,
            size: 40.0,
          ),
        ));
  }
}
