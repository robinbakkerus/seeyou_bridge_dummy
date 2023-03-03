import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:seeyou_bridge_dummy/model/card.dart';
import 'package:seeyou_bridge_dummy/widget/card_widget.dart';
import 'package:seeyou_bridge_dummy/helper/widget_helper.dart';
import 'package:flutter/material.dart';

import '../event/app_events.dart';

/// this page is used to select all the 13 open cards from the dummy that will
/// be presented of the play_card_page
/// When a card is clicked it will be blurred

class SelectCardsPage extends StatefulWidget {
  const SelectCardsPage({super.key});

  @override
  State<SelectCardsPage> createState() => _SelectCardsPageState();
}

class _SelectCardsPageState extends State<SelectCardsPage> {
  _SelectCardsPageState() {
    AppEvents.onReset((event) => _refresh());
    AppEvents.onCardEvent((event) => _refresh());
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildStack(),
    );
  }

  Widget _buildStack() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [_listview(), _selectTrumpCardRowWidget()],
    );
  }

  Widget _listview() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: CardType.values.length + 1,
        itemBuilder: (BuildContext ctxt, int index) {
          if (index < CardType.values.length) {
            return _cardRow(CardType.values[index]);
          } else {
            return SizedBox(
              height: 800,
              child: Container(),
            );
            //BridgeShowPage();
          }
        });
  }

  Widget _cardRow(CardType cardType) {
    Widget leftCol = WidgetHelper.cardImageForSelectPage(cardType.name);
    return Row(children: [leftCol, _rightCol(cardType)]);
  }

  Widget _rightCol(CardType type) {
    return Expanded(
      child: Column(
        children: [_rightColRow1(type), _rightColRow2(type)],
      ),
    );
  }

  Widget _rightColRow1(CardType type) {
    List<Widget> items = [];

    for (int i = 14; i > 7; i--) {
      BridgeCard card = PlayData.instance.cards
          .firstWhere((c) => c.type == type && c.nr == i);
      Widget w = CardSelectWidget.ofCard(card);
      items.add(w);
    }
    return Row(
      children: items,
    );
  }

  Widget _rightColRow2(CardType type) {
    List<Widget> items = [];

    for (int i = 7; i > 1; i--) {
      BridgeCard card = PlayData.instance.cards
          .firstWhere((c) => c.type == type && c.nr == i);
      Widget w = CardSelectWidget.ofCard(card);
      items.add(w);
    }
    return Row(
      children: items,
    );
  }

  Widget _selectTrumpCardRowWidget() {
    int cnt = PlayData.instance.cardsSelectedCount();
    if (cnt < 13) {
      return Container();
    }

    double screenWidth = PlayData.instance.screenWidth;
    return Positioned(
        left: screenWidth / 5.0,
        bottom: 20,
        child: Container(
          width: screenWidth / 2.0,
          height: screenWidth / 6.0,
          color: Colors.blue,
          child: Column(
            children: [
              const Text(
                'Selecteer troef kaart',
                style: TextStyle(fontSize: 40),
              ),
              _buildTrumCardWidgetRow(),
            ],
          ),
        ));
  }

  Widget _buildTrumCardWidgetRow() {
    List<Widget> buttons = [];
    for (var ct in CardType.values) {
      Widget btn = TrumpCardWidget(ct, false);
      buttons.add(btn);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}
