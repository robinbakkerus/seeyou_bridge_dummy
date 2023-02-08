import 'package:seeyou_bridge_dummy/widget/card_widget.dart';

import '../data/play_data.dart';
import '../model/card.dart';

class CardDataHelper {
  /// build a list of list<BridgeCard> that can be used to fill the listview in
  /// PlayCard widget. Note these list may contain null value indicating empty cards
  static List<List<CardPlayWidget>> buildOpenDummyCardsList() {
    // first collect all cards played sorted in separate lists
    List<List<BridgeCard>> cardsPlayed = [];

    for (var cardType in CardType.values) {
      _fillCards(cardType, cardsPlayed);
    }

    return _buildResultList(cardsPlayed);
  }

  /// ---- private methods --------------

  static List<List<CardPlayWidget>> _buildResultList(
      List<List<BridgeCard>> cardsPlayed) {
    List<List<CardPlayWidget>> result = [];

    int max = _calcListSize(cardsPlayed);

    for (int row = 0; row < max; row++) {
      result.add(_buildWidgetList(cardsPlayed, row));
    }

    return result;
  }

  // put all played cards sorted in a list
  static void _fillCards(
      CardType cardType, List<List<BridgeCard>> cardsPlayed) {
    List<BridgeCard> cards = PlayData.instance.cards
        .where((c) => c.type == cardType && c.selected)
        .toList();
    cards.sort((a, b) => b.nr.compareTo(a.nr));
    cardsPlayed.add(cards);
  }

  static int _calcListSize(List<List<BridgeCard>> cardsPlayed) {
    int max = 0;
    for (var cardType in CardType.values) {
      int n = cardsPlayed[cardType.index].length;
      if (n > max) {
        max = n;
      }
    }
    return max;
  }

  static List<CardPlayWidget> _buildWidgetList(
      List<List<BridgeCard>> cardsPlayed, int row) {
    List<CardPlayWidget> r = [];

    for (var cardType in CardType.values) {
      List<BridgeCard> cards = cardsPlayed[cardType.index];
      if (cards.length > row) {
        BridgeCard card = cards[row];
        r.add(CardPlayWidget.ofCard(card));
      } else {
        r.add(CardPlayWidget.emptyCard());
      }
    }
    return r;
  }
}
