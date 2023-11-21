import 'package:seeyou_bridge_dummy/widget/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'helper/settings_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  BridgeSettingsHelper.getAllSettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget homeWidget = MaterialApp(
      title: 'See You Bridge Dummy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'See you bridge dummy'),
      debugShowCheckedModeBanner: false,
    );

    FlutterNativeSplash.remove();
    return homeWidget;
  }
}
