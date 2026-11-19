import 'package:flutter/foundation.dart';

import '../models/destination.dart';
import '../services/destination_service.dart';

enum Status { loading, error, done }

class DestinationsProvider extends ChangeNotifier {
  final DestinationService _service = DestinationService();

  Status status = Status.loading;
  List<Destination> items = [];
  String error = '';

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