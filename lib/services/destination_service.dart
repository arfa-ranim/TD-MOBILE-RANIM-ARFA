import 'dart:math';

import '../models/destination.dart';

// Bonus 5: fake server (waits 2 seconds, fails 1 time in 2)
class DestinationService {
  Future<List<Destination>> fetchAll() async {
    await Future.delayed(const Duration(seconds: 2)); // fake network
    if (Random().nextBool()) throw Exception('No internet');
    return destinations;
  }
}