import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';

// Item 1: screen that lists the favorites
class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Item 1: watch the favorites list
    final trips = context.watch<FavoritesProvider>().all;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        actions: [
          // Item 4: "Clear all" button (read, because it is a callback)
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => context.read<FavoritesProvider>().clear(),
          ),
        ],
      ),
      // Item 1: "No trips yet" message when the list is empty
      body: trips.isEmpty
          ? const Center(child: Text('No trips yet'))
          : ListView(
        children: [
          for (final name in trips)
            ListTile(
              title: Text(name),
              // Item 3: remove button on each line (calls toggle)
              trailing: IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: () =>
                    context.read<FavoritesProvider>().toggle(name),
              ),
            ),
        ],
      ),
    );
  }
}