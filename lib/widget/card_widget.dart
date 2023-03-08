// ignore_for_file: must_be_immutable

import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:seeyou_bridge_dummy/event/app_events.dart';
import 'package:seeyou_bridge_dummy/model/card.dart';
import 'package:flutter/material.dart';

import 'package:seeyou_bridge_dummy/helper/widget_helper.dart';

/// This widget is used in select_card_page
/// when a card is clicked it is added to PlayData.cardsSelected
class CardSelectWidget extends StatefulWidget {
  final CardType type;
  // 0 indicates and empty card
  final int nr;
  bool selected;

  CardSelectWidget(this.type, this.nr, this.selected, {Key? key})
      : super(key: key);

  factory CardSelectWidget.ofCard(BridgeCard card) {
    return CardSelectWidget(card.type, card.nr, card.selected);
  }

  factory CardSelectWidget.emptyCard() {
    return CardSelectWidget(CardType.harten, 0, false);
  }

  @override
  State<CardSelectWidget> createState() => _CardSelectWidgetState();
}

///---------------------
class _CardSelectWidgetState extends State<CardSelectWidget> {
  @override
  Widget build(BuildContext context) {
    String txt = WidgetHelper.parseNr(widget.nr);
    return widget.selected
        ? WidgetHelper.showOnlyCard(txt, ShowPage.select)
        : WidgetHelper.clickableCard(txt, ShowPage.select, _onTap);
  }

  void _onTap() {
    if (PlayData.instance.cardsSelected.length < 13) {
      setState(() {
        widget.selected = true;
      });

      PlayData.instance.selectCard(widget.type, widget.nr);
      AppEvents.fireCardEvent();
    }
  }
}

///--------------------------------------------------------------------------

/// This widget is used in play_card_page
/// when a card is clicked it is added to PlayData.cardsPlayed
class CardPlayWidget extends StatefulWidget {
  final CardType type;
  // 0 indicates and empty card
  final int nr;
  bool selected;

  CardPlayWidget(this.type, this.nr, this.selected, {Key? key})
      : super(key: key);

  factory CardPlayWidget.ofCard(BridgeCard card) {
    return CardPlayWidget(card.type, card.nr, card.selected);
  }

  factory CardPlayWidget.emptyCard() {
    return CardPlayWidget(CardType.harten, 0, false);
  }

  @override
  State<CardPlayWidget> createState() => _CardPlayWidgetState();
}

class _CardPlayWidgetState extends State<CardPlayWidget> {
  @override
  Widget build(BuildContext context) {
    String txt = WidgetHelper.parseNr(widget.nr);
    return WidgetHelper.clickableCard(txt, ShowPage.play, _onTap);
  }

  void _onTap() {
    setState(() {
      widget.selected = true;
    });

    PlayData.instance.playCard(widget.type, widget.nr);
    AppEvents.fireCardEvent();
  }
}

///------------- trump card -------------------------

class TrumpCardWidget extends StatefulWidget {
  // const TrumpCard({super.key});

  final CardType cardType;
  bool selected;

  TrumpCardWidget(this.cardType, this.selected, {Key? key}) : super(key: key);

  factory TrumpCardWidget.ofCard(BridgeCard card) {
    return TrumpCardWidget(card.type, card.selected);
  }

  @override
  State<TrumpCardWidget> createState() => _TrumpCardWidgetState();
}

///------------
class _TrumpCardWidgetState extends State<TrumpCardWidget> {
  void _onTrumpCardTap() async {
    PlayData.instance.activeTrumpCard = widget.cardType;
    setState(() {
      widget.selected = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    AppEvents.fireCardEvent();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetHelper.clickableTrumpCard(
        widget.cardType, _onTrumpCardTap, widget.selected);
  }
}
