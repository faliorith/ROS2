import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final l10n = AppLocalizations.of(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: l10n.language,
      onSelected: (String languageCode) {
        languageService.setLanguage(languageCode);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'ru',
          child: Row(
            children: [
              Image.asset(
                'assets/flags/ru.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text('Русский'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              Image.asset(
                'assets/flags/en.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text('English'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'kk',
          child: Row(
            children: [
              Image.asset(
                'assets/flags/kk.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text('Қазақша'),
            ],
          ),
        ),
      ],
    );
  }
} 