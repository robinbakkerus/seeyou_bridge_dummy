import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:seeyou_bridge_dummy/helper/data_helper.dart';
import 'package:seeyou_bridge_dummy/widget/card_widget.dart';
import 'package:flutter/material.dart';

import '../event/app_events.dart';
import '../helper/widget_helper.dart';

/// This is main page that shows all the open cards from the dummy
/// when a card is clicked it will disappear

class PlayCardPage extends StatefulWidget {
  const PlayCardPage({super.key});

  @override
  State<PlayCardPage> createState() => _PlayCardPageState();
}

class _PlayCardPageState extends State<PlayCardPage> {
  // final List<String> _cardImages = CardType.values.map((e) => e.name).toList();
  List<List<CardPlayWidget>> _cardsPlayed =
      CardDataHelper.buildOpenDummyCardsList();

  _PlayCardPageState() {
    AppEvents.onReset((event) => _onReset(event));
    AppEvents.onCardEvent((event) => _onCardPlayed(event));
    AppEvents.onShowPage((event) => _onShowPage(event));
  }

  @override
  void initState() {
    super.initState();
  }

  void _onReset(ResetEvent event) {
    PlayData.instance.activeTrumpCard = null;
    _fillAllCards();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _listview());
  }

  void _onCardPlayed(CardEvent event) {
    if (PlayData.instance.activePage == ShowPage.play) {
      _fillAllCards();
    }
  }

  void _onShowPage(ShowPageEvent event) {
    if (PlayData.instance.activePage == ShowPage.play) {
      _fillAllCards();
    }
  }

  void _fillAllCards() {
    setState(() {
      _cardsPlayed = CardDataHelper.buildOpenDummyCardsList();
    });
  }

  ListView _listview() {
    return ListView.builder(
        itemCount: _cardsPlayed.length + 1,
        itemBuilder: (BuildContext ctxt, int index) {
          return index == 0 ? _topRow() : _cardRow(_cardsPlayed[index - 1]);
        });
  }

  Widget _topRow() {
    List<String> cardImages = CardDataHelper.buildTopRowCardImages();

    var cols = cardImages
        .map(
          (e) => _cardImageItem(e, ShowPage.play),
        )
        .toList();

    return IntrinsicWidth(
      child: Row(
        children: cols,
      ),
    );
  }

  Widget _cardRow(List<CardPlayWidget> cardList) {
    var cols = cardList
        .map(
          (card) => Expanded(child: card),
        )
        .toList();

    return IntrinsicWidth(
      child: Row(
        children: cols,
      ),
    );
  }

  Widget _cardImageItem(String txt, ShowPage forPage) {
    return WidgetHelper.cardImage(txt, forPage);
  }
}
