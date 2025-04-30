import 'package:flutter/material.dart';
import 'package:flutter_ros/l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.favorites),
      ),
      body: Center(
        child: Text(
          l10n.noFavorites,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
} 