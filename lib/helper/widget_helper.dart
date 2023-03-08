import 'package:seeyou_bridge_dummy/data/play_data.dart';
import 'package:flutter/material.dart';
import 'package:seeyou_bridge_dummy/model/card.dart';

import '../event/app_events.dart';

class WidgetHelper {
  /// returns the card image. On the play (main) page the image is Expanded
  static Widget cardImage(String name, ShowPage forPage) {
    String imageName = _buildImageName(name);

    return forPage == ShowPage.play
        ? Expanded(
            child: _cardImageContainer(imageName, forPage),
          )
        : _cardImageContainer(imageName, forPage);
  }

  static String _buildImageName(String name) {
    String imageName = "assets/$name.jpg";
    return imageName;
  }

  ///
  static Widget _cardText(String txt, ShowPage forPage) {
    double h = _getCardHeight(forPage);
    double w = _getCardWidth(forPage);
    double fontsize = _getFontHeight(forPage);
    bool showBox = txt.isNotEmpty;

    return Container(
      height: h,
      width: w,
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(1.0),
      decoration: showBox
          ? BoxDecoration(
              border: Border.all(color: Colors.brown),
            )
          : null,
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              height: 0.9,
              fontSize: fontsize,
              // fontWeight: FontWeight.bold,
              fontFamily: 'ArialNarrow',
              color: Colors.black),
        ),
      ),
    );
  }

  static String parseNr(int nr) {
    if (nr == 0) {
      return '';
    } else if (nr < 11) {
      return nr.toString();
    } else if (nr == 14) {
      return 'A';
    } else if (nr == 13) {
      return 'H';
    } else if (nr == 12) {
      return 'V';
    } else if (nr == 11) {
      return 'B';
    } else {
      return '?';
    }
  }

  static Widget clickableCard(
      String txt, ShowPage forPage, void Function() func) {
    return InkWell(
      child: Container(
        child: WidgetHelper._cardText(txt, forPage),
      ),
      onTap: () => func(),
    );
  }

  static Widget showOnlyCard(
    String txt,
    ShowPage forPage,
  ) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        child: WidgetHelper._cardText(txt, forPage),
      ),
    );
  }

  static Widget clickableTrumpCard(
      CardType cartType, void Function() func, bool selected) {
    String imageName = _buildImageName(cartType.name);
    return InkWell(
      onTap: () => func(),
      child: _trumpCardImageContainer(imageName, ShowPage.select, selected),
    );
  }

  static Container _cardImageContainer(String imageName, ShowPage forPage) {
    return Container(
        height: _getCardHeight(forPage),
        width: _getCardWidth(forPage),
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.brown, width: 2)),
        child: Image(image: AssetImage(imageName)));
  }

  static Container _trumpCardImageContainer(
      String imageName, ShowPage forPage, bool selected) {
    BoxDecoration decoration = selected
        ? BoxDecoration(border: Border.all(color: Colors.yellow, width: 10))
        : BoxDecoration(border: Border.all(color: Colors.blue, width: 0));

    return Container(
        height: _getCardHeight(forPage),
        width: _getCardHeight(forPage), // same size
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        decoration: decoration,
        child: Image(image: AssetImage(imageName)));
  }

  static Container cardImageForSelectPage(String name) {
    String imageName = "assets/$name.jpg";
    return Container(
        height: _getCardHeight(ShowPage.select) * 2.0,
        width: _getCardWidth(ShowPage.select),
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown),
        ),
        child: Image(image: AssetImage(imageName)));
  }

  static bool _isforPlayPage(ShowPage page) {
    return page == ShowPage.play;
  }

  static double _getCardWidth(ShowPage forPage) {
    double sw = PlayData.instance.screenWidth;
    if (sw < 0) {
      sw = 800.0;
    }

    if (_isforPlayPage(forPage)) {
      return sw / 4.2;
    } else {
      return sw / 8.5;
    }
  }

  static double _getCardHeight(ShowPage forPage) {
    double h = 0.0;
    if (_isforPlayPage(forPage)) {
      int maxCount = PlayData.instance.getMaxSelectedCardCount();
      int showCount = PlayData.instance.showCardsCount;
      if (maxCount > showCount) {
        h = PlayData.instance.screenHeight / (showCount + 1);
      } else if (maxCount > 5) {
        h = PlayData.instance.screenHeight / (maxCount + 1);
      } else {
        h = PlayData.instance.screenHeight / 6;
      }
    } else {
      h = PlayData.instance.screenHeight / 8.5;
    }

    if (h > 0) {
      return h;
    } else {
      return 150.0;
    }
  }

  static double _getFontHeight(ShowPage forPage) {
    double f = _isforPlayPage(forPage) ? 0.95 : 0.8;
    return _getCardHeight(forPage) * f;
  }
}
