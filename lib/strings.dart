const strings = NLStrings();

abstract interface class Strings {
  String get close;

  String get openChest;

  String successOpenChest(String animal);

  String get alreadyOpenedChest;
}

class NLStrings implements Strings {
  const NLStrings();

  @override
  String get alreadyOpenedChest => 'Helaas! Je hebt deze kist is al geopend.';

  @override
  String get close => 'Sluiten';

  @override
  String get openChest => 'Open kist';

  @override
  String successOpenChest(String animal) => 'Gefeliciteerd! Je hebt het kado met de $animal gevonden.';
}
