import 'package:seeyou_bridge_dummy/event/app_events.dart';
import 'package:flutter/material.dart';

import '../model/card.dart';

class PlayData {
  PlayData._() {
    _initCards();
  }

  static final instance = PlayData._();

  /// this property maintains the overall state
  List<BridgeCard> cards = [];

  /// these two are needed to support undo
  List<BridgeCard> cardsSelected = [];
  List<BridgeCard> cardsPlayed = [];

  /// screen sizes, will be set
  double screenWidth = 400.0;
  double screenHeight = 500.0;

  /// how many cards do we want to display, default is 8 this can be changed in the settings pag
  int _showCards = 8;
  int get showCardsCount => _showCards;
  void setShowCardsCount(int value) {
    _showCards = value;
  }

  /// language
  String _language = 'nl';
  String get language => _language;
  void setLanguage(String value) {
    _language = value;
  }

  bool firstTime = true;

  /// bool to indicate if tabbar is visible
  bool showTabBar = true;

  //---- methods -----------------------------------

  void _initCards() {
    cards = [];

    for (var ct in CardType.values) {
      for (int i = 2; i < 15; i++) {
        BridgeCard card = BridgeCard(ct, i);
        cards.add(card);
      }
    }

    cardsSelected = [];
    cardsPlayed = [];
  }

  ///---------------------------
  void selectCard(CardType cardType, int nr) {
    BridgeCard card = cards.firstWhere((c) => c.nr == nr && c.type == cardType);
    card.selected = true;
    cardsPlayed.remove(card);
    cardsSelected.add(card);
  }

  ///------
  void playCard(CardType cardType, int nr) {
    BridgeCard card = cards.firstWhere((c) => c.nr == nr && c.type == cardType);
    card.selected = false;
    cardsSelected.remove(card);
    cardsPlayed.add(card);
  }

  ///-----
  void reset() {
    _initCards();
  }

  int cardsSelectedCount() => cards.where((c) => c.selected).length;
  int cardsPlayedCount() => 13 - (cards.where((c) => c.selected).length);

  ///---------
  void undoLastCardSelected() {
    if (cardsSelected.isEmpty) {
      return;
    }

    BridgeCard lastCard = cardsSelected.last;
    BridgeCard card =
        cards.firstWhere((c) => c.type == lastCard.type && c.nr == lastCard.nr);
    card.selected = false;
    cardsSelected.remove(lastCard);

    AppEvents.fireCardEvent();
  }

  ///
  void undoLastCardPlayed() {
    if (cardsPlayed.isEmpty) {
      return;
    }

    BridgeCard lastCard = cardsPlayed.last;
    BridgeCard card =
        cards.firstWhere((c) => c.type == lastCard.type && c.nr == lastCard.nr);
    card.selected = true;
    cardsPlayed.remove(lastCard);

    AppEvents.fireCardEvent();
  }

  /// return the max nr of cards that is selected for a particular card type
  int getMaxSelectedCardCount() {
    int max = 0;
    for (var ct in CardType.values) {
      int cnt = cards.where((c) => c.type.code == ct.code && c.selected).length;
      if (cnt > max) {
        max = cnt;
      }
    }

    return max;
  }

  /// initially called to obtain sizes
  void setScreenSizes(BuildContext context) {
    /// Full screen width and height
    screenWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    /// Height (without SafeArea)
    var padding = MediaQuery.of(context).viewPadding;

    /// Height (without status and toolbar)
    screenHeight = height - padding.top - kToolbarHeight;
  }
}
