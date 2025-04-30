import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  late Widget enterHost;

  late Widget enterPort;

  late Widget invalidPort;

  String? connectionError;

  String? disconnectionError;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<void> load() async {
    String jsonString = await rootBundle.loadString('assets/translations/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Геттеры, использующие translate
  String get appTitle => translate('appTitle');
  String get login => translate('login');
  String get register => translate('register');
  String get email => translate('email');
  String get password => translate('password');
  String get confirmPassword => translate('confirmPassword');
  String get noAccount => translate('noAccount');
  String get hasAccount => translate('hasAccount');
  String get myRecipes => translate('myRecipes');
  String get addRecipe => translate('addRecipe');
  String get editRecipe => translate('editRecipe');
  String get deleteRecipe => translate('deleteRecipe');
  String get ingredients => translate('ingredients');
  String get steps => translate('steps');
  String get save => translate('save');
  String get cancel => translate('cancel');
  String get delete => translate('delete');
  String get title => translate('title');
  String get description => translate('description');
  String get addPhoto => translate('addPhoto');
  String get loginError => translate('loginError');
  String get registerError => translate('registerError');
  String get emailRequired => translate('emailRequired');
  String get passwordRequired => translate('passwordRequired');
  String get invalidEmail => translate('invalidEmail');
  String get passwordTooShort => translate('passwordTooShort');
  String get confirmPasswordRequired => translate('confirmPasswordRequired');
  String get passwordsDoNotMatch => translate('passwordsDoNotMatch');
  String get noRecipes => translate('noRecipes');
  String get edit => translate('edit');
  String get language => translate('language');
  String get favorites => translate('favorites');
  String get noFavorites => translate('noFavorites');
  String get profile => translate('profile');
  String get logout => translate('logout');
  String get userNotFound => translate('userNotFound');
  String get wrongPassword => translate('wrongPassword');
  String get userDisabled => translate('userDisabled');
  String get networkError => translate('networkError');
  String get resetPasswordEmailSent => translate('resetPasswordEmailSent');
  String get resetPasswordError => translate('resetPasswordError');
  String get forgotPassword => translate('forgotPassword');
  String get recipeDetails => translate('recipeDetails');
  String get pleaseEnterTitle => translate('pleaseEnterTitle');
  String get pleaseEnterDescription => translate('pleaseEnterDescription');
  String get pickImage => translate('pickImage');
  String get ingredient => translate('ingredient');
  String get addIngredient => translate('addIngredient');
  String get step => translate('step');
  String get addStep => translate('addStep');
  String get cookingTime => translate('cookingTime');
  String get servings => translate('servings');
  String get difficulty => translate('difficulty');
  String get cookingMethod => translate('cookingMethod');
  String get rating => translate('rating');
  String get tags => translate('tags');
  String get minutes => translate('minutes');
  String get people => translate('people');
  String get easy => translate('easy');
  String get medium => translate('medium');
  String get hard => translate('hard');
  String get favorite => translate('favorite');
  String get unfavorite => translate('unfavorite');
  String get home => translate('home');
  String get settings => translate('settings');
  String get theme => translate('theme');
  String get darkMode => translate('darkMode');
  String get lightMode => translate('lightMode');
  String get system => translate('system');
  String get about => translate('about');
  String get version => translate('version');
  String get rosStatus => translate('rosStatus');
  String get connected => translate('connected');
  String get disconnected => translate('disconnected');
  String get connect => translate('connect');
  String get disconnect => translate('disconnect');
  String get host => translate('host');
  String get port => translate('port');
}
