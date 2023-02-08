enum CardType {
  schoppen(1, 'schoppen'),
  harten(2, 'harten'),
  ruiten(3, 'ruiten'),
  klaveren(4, 'klaver');

  final int code;
  final String name;

  const CardType(this.code, this.name);
}

class BridgeCard {
  final CardType type;
  final int nr;
  bool selected = false;

  BridgeCard(this.type, this.nr);
}
