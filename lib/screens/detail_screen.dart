import 'dart:async';

import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.destination});

  final Destination destination;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Weather> _weather;

  // Step 5: the Future is created ONCE, in initState
  @override
  void initState() {
    super.initState();
    _weather = WeatherService().fetch(
      widget.destination.lat,
      widget.destination.lng,
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;

    return Scaffold(
      appBar: AppBar(title: Text(d.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder<Weather>(
                  future: _weather,
                  builder: (context, snapshot) {
                    // Loading: spinner
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Error
                    if (snapshot.hasError) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Item 3: friendlier errors
                          Text(
                            snapshot.error is TimeoutException
                                ? 'Check your connection'
                                : 'Could not load the weather',
                          ),
                          const SizedBox(height: 12),
                          // Item 2: Retry button
                          ElevatedButton(
                            onPressed: () => setState(() {
                              _weather = WeatherService().fetch(
                                widget.destination.lat,
                                widget.destination.lng,
                              );
                            }),
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    }

                    // Done: show the data
                    final w = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Item 1: icon
                            Icon(w.icon, size: 32),
                            const SizedBox(width: 8),
                            Text(
                              '${w.temperature} °C',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Item 1: label under the temperature
                        Text(w.label),
                        const SizedBox(height: 4),
                        Text('Wind ${w.windSpeed} km/h'),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(d.tagline, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}