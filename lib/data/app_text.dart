/*
an enum with all possible text keys
*/
import 'package:seeyou_bridge_dummy/data/play_data.dart';

enum Tk {
  size,
  lang,
  done,
  reset,
  select,
  trump;
}

/*
this class contains all text in different languages
*/
class TextItem {
  final String lang;
  final Tk key;
  final String text;

  TextItem(this.lang, this.key, this.text);
}

class AppText {
  static final List<TextItem> _allTextItems = [];

  AppText._() {
    _initialize();
  }

  static final instance = AppText._();

  String getText(Tk tk) {
    String lang = PlayData.instance.language;
    return _allTextItems.firstWhere((e) => e.lang == lang && e.key == tk).text;
  }

  //---------------
  void _initialize() {
    //---------
    _add('nl', Tk.done, 'Klaar');
    _add('en', Tk.done, 'Ready');
    _add('fr', Tk.done, 'Fini');
    _add('de', Tk.done, 'Fertig');
    _add('es', Tk.done, 'Final');

    //---------
    _add('nl', Tk.size, 'Hoeveel kaarten tonen');
    _add('en', Tk.size, 'How many cards to display');
    _add('fr', Tk.size, 'Afficher combien de cartes');
    _add('de', Tk.size, 'Zeigen Sie, wie viele Karten');
    _add('es', Tk.size, 'Mostrar cuántas tarjetas');

    //---------
    _add('nl', Tk.lang, 'Taal');
    _add('en', Tk.lang, 'Language');
    _add('fr', Tk.lang, 'Idioma');
    _add('de', Tk.lang, 'Sprache');
    _add('es', Tk.lang, 'Langue');

    //---------
    _add('nl', Tk.reset, 'Herstel default waardes');
    _add('en', Tk.reset, 'Restore default values');
    _add('fr', Tk.reset, 'Restaurer les valeurs par défaut');
    _add('de', Tk.reset, 'Standardwerte wiederherstellen');
    _add('es', Tk.reset, 'Restaurar valores predeterminados');

    //---------
    _add('nl', Tk.select, 'Selecteer');
    _add('en', Tk.select, 'Select');
    _add('fr', Tk.select, 'Sélectionner');
    _add('de', Tk.select, 'Wählen');
    _add('es', Tk.select, 'Seleccionar');

    //---------
    _add('nl', Tk.trump, 'troef kaart');
    _add('en', Tk.trump, 'trump card');
    _add('fr', Tk.trump, 'atout');
    _add('de', Tk.trump, 'trumpfkarte');
    _add('es', Tk.trump, 'carta de triunfo');
  }

  void _add(String lang, Tk tk, String text) {
    _allTextItems.add(TextItem(lang, tk, text));
  }
}
