import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destination.dart';
import '../providers/favorites_provider.dart';

// Guided (Step 5): the card with the heart
class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    // Guided (Step 5): watch to SHOW
    final isFav =
    context.watch<FavoritesProvider>().isFavorite(destination.name);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(destination.name),
        subtitle: Text(destination.tagline),
        trailing: IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          color: isFav ? Colors.red : null,
          // Guided (Step 5): read to DO
          onPressed: () =>
              context.read<FavoritesProvider>().toggle(destination.name),
        ),
      ),
    );
  }
}