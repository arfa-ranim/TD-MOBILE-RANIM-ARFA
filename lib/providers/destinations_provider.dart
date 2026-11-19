import 'package:flutter/foundation.dart';

import '../models/destination.dart';
import '../services/destination_service.dart';

// Bonus 5: the 3 states
enum Status { loading, error, done }

// Bonus 5: provider that loads the data
class DestinationsProvider extends ChangeNotifier {
  final DestinationService _service = DestinationService();

  Status status = Status.loading;
  List<Destination> items = [];
  String error = '';

  // Bonus 5: load() calls notifyListeners() twice
  // (also called by the Retry button)
  Future<void> load() async {
    status = Status.loading;
    notifyListeners(); // 1st: show the spinner

    try {
      items = await _service.fetchAll();
      status = Status.done;
    } catch (e) {
      error = e.toString();
      status = Status.error;
    }

    notifyListeners(); // 2nd: show the result
  }
}