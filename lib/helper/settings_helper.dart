import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SettingType {
  string,
  int,
  bool;
}

enum BridgeSetting {
  showCardCount('showCardCount', SettingType.int),
  language('language', SettingType.string),
  firstTime('firstTime', SettingType.bool);

  final String key;
  final SettingType type;

  const BridgeSetting(this.key, this.type);
}

class BridgeSettingsHelper {
  static late SharedPreferences _prefs;

  static void getAllSettings() async {
    _prefs = await SharedPreferences.getInstance();

    int showCount = _prefs.getInt(BridgeSetting.showCardCount.key) ?? 9;
    PlayData.instance.setShowCardsCount(showCount);

    String lang = _prefs.getString(BridgeSetting.language.key) ?? 'nl';
    PlayData.instance.setLanguage(lang);

    bool firsttime = _prefs.getBool(BridgeSetting.firstTime.key) ?? true;
    PlayData.instance.firstTime = firsttime;
  }

  static void saveIntSetting(BridgeSetting setting, Object value) {
    if (setting.type == SettingType.int) {
      _prefs.setInt(setting.key, value as int);
    } else if (setting.type == SettingType.bool) {
      _prefs.setBool(setting.key, value as bool);
    } else {
      _prefs.setString(setting.key, value as String);
    }
  }

  static void clearAllSetting() async {
    for (var s in BridgeSetting.values) {
      await _prefs.remove(s.key);
    }

    getAllSettings();
  }
}
