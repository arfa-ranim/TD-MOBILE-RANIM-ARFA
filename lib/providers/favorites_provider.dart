import 'package:flutter/foundation.dart';

// Guided (Step 2): the ChangeNotifier that holds the favorites
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _names = {};

  // Guided (Step 2): read-only access for the UI
  // (`all` is used by My Trips, item 1)
  List<String> get all => _names.toList();
  int get count => _names.length;

  bool isFavorite(String name) => _names.contains(name);

  // Guided (Step 2): add or remove a favorite
  // Also used by item 3 (remove button in My Trips)
  void toggle(String name) {
    if (_names.contains(name)) {
      _names.remove(name);
    } else {
      _names.add(name);
    }
    notifyListeners();
  }

  // Item 4: "Clear all", must end with notifyListeners()
  void clear() {
    _names.clear();
    notifyListeners();
  }
}