// Guided (Step 1): the data model
class Destination {
  const Destination({required this.name, required this.tagline});

  final String name;
  final String tagline;
}

// Guided (Step 1): the hard-coded list
// Bonus 5: DestinationService now returns this list
const destinations = [
  Destination(name: 'Djerba', tagline: 'Island & beaches'),
  Destination(name: 'Tozeur', tagline: 'Desert oasis'),
  Destination(name: 'Sousse', tagline: 'Medina & coast'),
  Destination(name: 'Tabarka', tagline: 'Coral coast & forests'),
  Destination(name: 'Kairouan', tagline: 'The Great Mosque'),
];