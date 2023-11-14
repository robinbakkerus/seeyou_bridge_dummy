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
  trump,
  about,
  help1,
  help2;
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

    //---------
    _add('nl', Tk.about, '''
Contact: zonnebloem.software@gmail.com
website: zonnebloem-software.web.app

See you bridge dummy is gratis
en bevat ook geen irritante advertenties.
Wilt u toch iets betalen ...
donneer dan de stichting die blindengeleidehonden opleidt:  ''');
    _add('en', Tk.about, '''
contact: zonnebloem.software@gmail.com
website: zonnebloem-software.web.app

See you bridge dummy is free and contains no advertisements.
Do you still want to pay something ...
Then donate to the foundation that trains 
guide dogs for the blind:    ''');
    _add('fr', Tk.about, '''
contact: zonnebloem.software@gmail.com
website: zonnebloem-software.web.app

See you bridge dummy is free and contains no advertisements.
Do you still want to pay something ...
Then donate to the foundation that trains 
guide dogs for the blind:  ''');
    _add('de', Tk.about, '''
contact: zonnebloem.software@gmail.com
website: zonnebloem-software.web.app

See you bridge dummy is free and contains no advertisements.
Do you still want to pay something ...
Then donate to the foundation that trains 
guide dogs for the blind:   ''');
    _add('es', Tk.about, '''
contact: zonnebloem.software@gmail.com
website: zonnebloem-software.web.app

See you bridge dummy is free and contains no advertisements.
Do you still want to pay something ...
Then donate to the foundation that trains 
guide dogs for the blind:    ''');

//---------
    _add('nl', Tk.help1, '''
`See you bridge dummy` is heel eenvoudig te gebruiken.
Zodra het contract is gemaakt en de dummy kaarten open liggen, dan kunnen deze kaarten op de `select` pagina worden geselecteerd. 
Als alle 13 kaarten gekozen zijn, dan kan de troef kaart worden geselecteerd.
Daarna springt het programma automatisch naar de `home` pagina, waar de dummy zo groot als mogelijk getoond worden.
Als een dummy kaart gespeeld wordt verdwijnt die van het scherm. 
Als alle kaarten gespeeld zijn dan spring het programma weer naar de 'select' pagina voor een nieuwe ronde.
Voor een korte en eenvoudige demo zie deze YouTube handleiding:    
(kopieer onderstaande url en open in een browser)''');
    _add('en', Tk.help1, '''
`See you bridge dummy` is very simple to use.
Once the contract has been made and the dummy cards are face up, these cards can be selected on the `select` page.
When all 13 cards have been chosen, the trump card can be selected.
Then the program automatically jumps to the `home` page, where the dummy is shown as large as possible.
When a dummy card is played, it disappears from the screen.
When all cards have been played, the program jumps back to the 'select' page for a new round.
For a short and simple demo see this YouTube tutorial:    
(copy the url below and open in a browser)
''');
    _add('fr', Tk.help1, '''
`See you bridge dummy` est très simple à utiliser.
Une fois que le contrat a été conclu et que les cartes factices sont face visible, ces cartes peuvent être sélectionnées sur la page "sélectionner".
Lorsque les 13 cartes ont été choisies, l'atout peut être sélectionné.
Ensuite, le programme passe automatiquement à la page d'accueil, où le mannequin est affiché aussi grand que possible.
Lorsqu'une carte factice est jouée, elle disparaît de l'écran.
Lorsque toutes les cartes ont été jouées, le programme revient à la page "sélectionner" pour un nouveau tour.
Pour une démo courte et simple, consultez ce tutoriel YouTube :
(copy the url below and open in a browser)
   ''');
    _add('de', Tk.help1, '''
`See you bridge dummy` ist sehr einfach zu bedienen.
Sobald der Vertrag abgeschlossen ist und die Dummy-Karten aufgedeckt sind, können diese Karten auf der „Auswählen“-Seite ausgewählt werden.
Wenn alle 13 Karten ausgewählt wurden, kann die Trumpfkarte ausgewählt werden.
Dann springt das Programm automatisch auf die 'Home'-Seite, wo der Dummy so groß wie möglich dargestellt wird.
Wenn eine Dummy-Karte gespielt wird, verschwindet sie vom Bildschirm.
Wenn alle Karten gespielt wurden, springt das Programm für eine neue Runde zurück auf die Seite „Auswählen“.
Eine kurze und einfache Demo finden Sie in diesem YouTube-Tutorial:   
(copy the url below and open in a browser)
''');
    _add('es', Tk.help1, '''
`See you bridge dummy` es muy simple de usar.
Una vez que se ha realizado el contrato y las cartas ficticias están boca arriba, estas cartas se pueden seleccionar en la página `seleccionar`.
Cuando se han elegido las 13 cartas, se puede seleccionar la carta de triunfo.
Luego, el programa salta automáticamente a la página de inicio, donde el dummy se muestra lo más grande posible.
Cuando se juega una carta ficticia, desaparece de la pantalla.
Cuando se han jugado todas las cartas, el programa vuelve a la página de "selección" para una nueva ronda.
Para ver una demostración breve y sencilla, consulte este tutorial de YouTube:  
(copy the url below and open in a browser)
''');

    //---------
    _add('nl', Tk.help2, 'Omschrijving van de menu items');
    _add('en', Tk.help2, 'Description of the menu items');
    _add('fr', Tk.help2, 'Description des éléments du menu');
    _add('de', Tk.help2, 'Beschreibung der Menüpunkte');
    _add('es', Tk.help2, 'Descripción de los elementos del menú.');
  }

  void _add(String lang, Tk tk, String text) {
    _allTextItems.add(TextItem(lang, tk, text));
  }
}
