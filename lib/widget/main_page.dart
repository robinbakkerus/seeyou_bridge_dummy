import 'package:seeyou_bridge_dummy/data/app_text.dart';
import 'package:seeyou_bridge_dummy/widget/play_card_page.dart';
import 'package:seeyou_bridge_dummy/widget/select_cards_page.dart';
import 'package:seeyou_bridge_dummy/widget/settings_page.dart';
import 'package:flutter/material.dart';

import '../data/play_data.dart';
import '../event/app_events.dart';
import 'app_bar.dart';
import 'help_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    AppEvents.onShowPage((event) => _onShowPage(event));
    AppEvents.onCardEvent((event) => _onCardEvent());
    AppEvents.onReset((event) => _onReset());
  }

  final Widget _showPage = const PlayCardPage();
  final Widget _playPage = const SelectCardsPage();
  final Widget _settingsPage = const BridgeSettings();
  final Widget _helpPage = BridgeHelpPage();

  int _stackIndex = 0;
  int _cardsSelectedCount = 0;

  void _onShowPage(ShowPageEvent event) {
    setState(() {
      PlayData.instance.activePage = event.page;
      _stackIndex = event.page.index;
    });
  }

  void _onCardEvent() async {
    setState(() {
      _cardsSelectedCount = PlayData.instance.cardsSelectedCount();
    });

    if (_cardsSelectedCount == 13 &&
        PlayData.instance.activeTrumpCard != null) {
      // await Future.delayed(const Duration(seconds: 1));
      PlayData.instance.showTabBar = false;
      AppEvents.fireShowPage(ShowPage.play);
    } else if (_cardsSelectedCount == 0) {
      await Future.delayed(const Duration(seconds: 1));
      AppEvents.fireReset();
      AppEvents.fireShowPage(ShowPage.select);
    }
  }

  void _onReset() {
    setState(() {
      _cardsSelectedCount = PlayData.instance.cardsSelectedCount();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlayData.instance.setScreenSizes(context);
    return Scaffold(
      appBar: _appbar(context),
      body: IndexedStack(
          index: _stackIndex,
          children: [_showPage, _playPage, _settingsPage, _helpPage]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatingButton(),
    );
  }

  bool _isPlayPage() => _stackIndex == 0;
  bool _isSelectPage() => _stackIndex == 1;

  PreferredSize? _appbar(BuildContext context) {
    if (PlayData.instance.showTabBar) {
      return PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: BridgeAppBar.buildAppBar(context));
    } else {
      return null;
    }
  }

  Widget? _floatingButton() {
    if (_isPlayPage() || _isSelectPage()) {
      return _floatingButtons();
    } else {
      return null;
    }
  }

  void _onUndoLastCardPlayed() {
    PlayData.instance.undoLastCardPlayed();
    AppEvents.fireCardEvent();
  }

  void _onUndoLastCardSelected() {
    PlayData.instance.undoLastCardSelected();
    AppEvents.fireCardEvent();
  }

  /// return a stack of floatingaction buttons
  Widget _floatingButtons() {
    String txt = '';
    Color color;
    void Function() func;

    String doneText = AppText.instance.getText(Tk.done);

    if (_isPlayPage()) {
      color = Colors.brown;
      txt = _cardsSelectedCount == 0 ? doneText : '$_cardsSelectedCount';
      func = _onUndoLastCardPlayed;
    } else {
      color = Colors.blue;
      txt = _cardsSelectedCount < 13 ? '$_cardsSelectedCount' : doneText;
      func = _onUndoLastCardSelected;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        _toggleTabBarButton(),
        _undoActionButton(txt, func, color),
      ],
    );
  }

  Positioned _undoActionButton(String txt, void Function() func, Color color) {
    return Positioned(
      bottom: 20,
      right: 10,
      child: FloatingActionButton.extended(
        label: Text(txt),
        heroTag: 'Undo',
        onPressed: () => func(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: color,
        icon: const Icon(
          Icons.settings_backup_restore,
          size: 40,
        ),
      ),
    );
  }

  Widget _toggleTabBarButton() {
    double topValue = PlayData.instance.showTabBar ? 100 : 50;
    IconData icon = PlayData.instance.showTabBar
        ? Icons.arrow_upward
        : Icons.arrow_downward;

    return Positioned(
      right: 0,
      top: topValue,
      child: FloatingActionButton(
        heroTag: 'back',
        onPressed: () {
          setState(() {
            PlayData.instance.showTabBar = !PlayData.instance.showTabBar;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 40,
        ),
      ),
    );
  }
}
