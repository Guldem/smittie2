enum ChestAnimals {
  bear('assets/images/animal_stickers/bear.png', 'de beer'),
  buffalo('assets/images/animal_stickers/buffalo.png', 'de buffalo'),
  chick('assets/images/animal_stickers/chick.png', 'het kuiken'),
  chicken('assets/images/animal_stickers/chicken.png', 'de kip'),
  cow('assets/images/animal_stickers/cow.png', 'de koe'),
  crocodile('assets/images/animal_stickers/crocodile.png', 'de krokodil'),
  dog('assets/images/animal_stickers/dog.png', 'de hond'),
  duck('assets/images/animal_stickers/duck.png', 'de eend'),
  elephant('assets/images/animal_stickers/elephant.png', 'de olifant'),
  frog('assets/images/animal_stickers/frog.png', 'de kikker'),
  giraffe('assets/images/animal_stickers/giraffe.png', 'de giraffe'),
  goat('assets/images/animal_stickers/goat.png', 'de geit'),
  gorilla('assets/images/animal_stickers/gorilla.png', 'de gorilla'),
  hippo('assets/images/animal_stickers/hippo.png', 'de nijlpaard'),
  horse('assets/images/animal_stickers/horse.png', 'het paard'),
  monkey('assets/images/animal_stickers/monkey.png', 'de aap'),
  moose('assets/images/animal_stickers/moose.png', 'de eland'),
  narwhal('assets/images/animal_stickers/narwhal.png', 'de narwal'),
  owl('assets/images/animal_stickers/owl.png', 'de uil'),
  panda('assets/images/animal_stickers/panda.png', 'de panda'),
  parrot('assets/images/animal_stickers/parrot.png', 'de papagaai'),
  penguin('assets/images/animal_stickers/penguin.png', 'de penguin'),
  pig('assets/images/animal_stickers/pig.png', 'het varken'),
  rabbit('assets/images/animal_stickers/rabbit.png', 'het konijn'),
  rhino('assets/images/animal_stickers/rhino.png', 'de neushoorn'),
  sloth('assets/images/animal_stickers/sloth.png', 'de luiaard'),
  snake('assets/images/animal_stickers/snake.png', 'de slang'),
  walrus('assets/images/animal_stickers/walrus.png', 'de walrus'),
  whale('assets/images/animal_stickers/whale.png', 'de walvis'),
  zebra('assets/images/animal_stickers/zebra.png', 'de zebra');

  const ChestAnimals(this.asset, this.displayName);

  final String asset;
  final String displayName;

  String? get rhyme => switch (this) {
        snake => 'Lekker spetteren in bad. Ojee, nu ben je wel helemaal nat.',
        owl => 'Baan, spuug, zand en modder. Er zit altijd wel ergens een klodder.',
        frog => 'Zelf met je handen eten, dat is te gek. Toch gaat het later beter met bestek.',
        bear => 'Een warme trui, dat is fijn. Dat geldt ook voor meneer Konijn.',
        dog => 'O,o,o wat een pret, letter voor letter wordt je naam gezet.',
        moose => 'Naald voor naald, pand en armen, om jou deze winter mee te verwarmen.',
        rabbit => 'Vind je dat niet hip? Samen met Nijntje op de wip.',
        chicken => 'Papa en mama staan je bij, dag en nacht. Dit helpt hen te vinden waar je zo naar smacht.',
        monkey => 'Je belangrijkste boek moet je goed bewaren, zodat je er veel avonturen mee kan sparen.',
        duck => 'Op het leven proosten kun je niet alleen, daarom is er zowel voor jou als Jelle 1!',
        horse => 'Shake it off, shake it off!',
        chick => 'De kleren van je broer zullen vast goed staan, maar soms wil je gewoon iets nieuws aan!',
        goat => 'Met al dat kwijlen kun je wel blijven dweilen...',
        gorilla => 'Wat kun je nou beter krijgen, dan iets om mee te rijgen?',
        parrot => 'In het bos vind je een egel, een haas en misschien zelfs een vos!',
        buffalo => 'We wilden iets geven van papier, en toen zei Charlie "deze hier!"',
        _ => null,
      };
}
