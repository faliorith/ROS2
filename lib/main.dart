import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/recipe_details_screen.dart';
import 'services/auth_service.dart';
import 'services/language_service.dart';
import 'models/recipe.dart';
import 'theme/app_theme.dart';
import 'l10n/app_localizations_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => LanguageService()),
      ],
      child: Consumer<LanguageService>(
        builder: (context, languageService, child) {
          return MaterialApp(
            title: 'Recipe Book',
            theme: AppTheme.lightTheme,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ru'),
              Locale('kk'),
            ],
            locale: languageService.locale,
            initialRoute: '/login',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/main': (context) => const MainScreen(),
              '/add_recipe': (context) => const AddRecipeScreen(),
              '/recipe_details': (context) {
                final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
                return RecipeDetailsScreen(recipe: recipe);
              },
            },
          );
        },
      ),
    );
  }
}
