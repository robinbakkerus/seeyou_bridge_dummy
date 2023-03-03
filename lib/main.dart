import 'package:seeyou_bridge_dummy/widget/main_page.dart';
import 'package:flutter/material.dart';

import 'helper/settings_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BridgeSettingsHelper.getAllSettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CUBD'),
      debugShowCheckedModeBanner: false,
    );
  }
}
