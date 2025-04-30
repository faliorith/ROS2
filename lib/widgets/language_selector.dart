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
      tooltip: l10n!.language,
      onSelected: (String languageCode) {
        languageService.setLocale(Locale(languageCode));
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              const Text('🇬🇧'),
              const SizedBox(width: 8),
              const Text('English'),
              if (languageService.locale.languageCode == 'en')
                const Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'ru',
          child: Row(
            children: [
              const Text('🇷🇺'),
              const SizedBox(width: 8),
              const Text('Русский'),
              if (languageService.locale.languageCode == 'ru')
                const Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'kk',
          child: Row(
            children: [
              const Text('🇰🇿'),
              const SizedBox(width: 8),
              const Text('Қазақша'),
              if (languageService.locale.languageCode == 'kk')
                const Icon(Icons.check, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
} 