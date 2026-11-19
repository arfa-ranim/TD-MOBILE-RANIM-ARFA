import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/destinations_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/destination_card.dart';
import 'my_trips_screen.dart';

// Guided (Step 4): the main screen
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Bonus 6: select instead of watch, rebuilds only when count changes
    // (in Step 4 this was context.watch<FavoritesProvider>().count)
    final count = context.select<FavoritesProvider, int>((p) => p.count);

    // Bonus 5: watch the loading provider
    final data = context.watch<DestinationsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Travel Journal'),
        actions: [
          // Item 2: IconButton that opens the My Trips screen
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MyTripsScreen()),
            ),
            // Guided (Step 4): the badge with the favorites count
            icon: Badge.count(
              count: count,
              isLabelVisible: count > 0,
              child: const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      // Bonus 5: switch on status (spinner / error + Retry / list)
      body: switch (data.status) {
      // Bonus 5: loading state
        Status.loading => const Center(child: CircularProgressIndicator()),
      // Bonus 5: error state with the Retry button
        Status.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(data.error),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.read<DestinationsProvider>().load(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      // Bonus 5: done state, the list
      // (in Step 4 the list used the `destinations` constant)
        Status.done => ListView(
          children: [
            for (final d in data.items) DestinationCard(destination: d),
          ],
        ),
      },
    );
  }
}