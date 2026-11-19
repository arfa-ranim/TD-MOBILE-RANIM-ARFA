import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/destinations_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/explore_screen.dart';

// Guided (Step 3): providers placed above the app
void main() {
  runApp(
    MultiProvider(
      providers: [
        // Guided (Step 3): favorites provider
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        // Bonus 5: registered here, load() called once in create
        ChangeNotifierProvider(create: (_) => DestinationsProvider()..load()),
      ],
      child: const TravelJournalApp(),
    ),
  );
}

// Guided (Step 3): the app
class TravelJournalApp extends StatelessWidget {
  const TravelJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const ExploreScreen(),
    );
  }
}