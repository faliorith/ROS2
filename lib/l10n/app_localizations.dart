import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'appTitle': 'Recipe Book',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'noAccount': 'Don\'t have an account?',
      'hasAccount': 'Already have an account?',
      'myRecipes': 'My Recipes',
      'addRecipe': 'Add Recipe',
      'editRecipe': 'Edit Recipe',
      'deleteRecipe': 'Delete Recipe',
      'ingredients': 'Ingredients',
      'steps': 'Steps',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'title': 'Title',
      'description': 'Description',
      'addPhoto': 'Add Photo',
      'loginError': 'Login failed',
      'registerError': 'Registration failed',
      'emailRequired': 'Please enter your email',
      'passwordRequired': 'Please enter your password',
      'invalidEmail': 'Please enter a valid email',
      'passwordTooShort': 'Password must be at least 6 characters',
      'confirmPasswordRequired': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'noRecipes': 'You don\'t have any recipes yet',
      'edit': 'Edit',
      'language': 'Language',
      'favorites': 'Favorites',
      'noFavorites': 'No favorite recipes yet',
      'profile': 'Profile',
      'logout': 'Logout',
      'userNotFound': 'User not found',
      'wrongPassword': 'Wrong password',
      'userDisabled': 'User account has been disabled',
      'networkError': 'Network error. Please check your connection',
      'resetPasswordEmailSent': 'Password reset email has been sent',
      'resetPasswordError': 'Failed to send password reset email',
      'forgotPassword': 'Forgot password?',
    },
    'ru': {
      'appTitle': 'Книга рецептов',
      'login': 'Войти',
      'register': 'Регистрация',
      'email': 'Email',
      'password': 'Пароль',
      'confirmPassword': 'Подтвердите пароль',
      'noAccount': 'Нет аккаунта?',
      'hasAccount': 'Уже есть аккаунт?',
      'myRecipes': 'Мои рецепты',
      'addRecipe': 'Добавить рецепт',
      'editRecipe': 'Редактировать рецепт',
      'deleteRecipe': 'Удалить рецепт',
      'ingredients': 'Ингредиенты',
      'steps': 'Шаги приготовления',
      'save': 'Сохранить',
      'cancel': 'Отмена',
      'delete': 'Удалить',
      'title': 'Название',
      'description': 'Описание',
      'addPhoto': 'Добавить фото',
      'loginError': 'Ошибка входа',
      'registerError': 'Ошибка регистрации',
      'emailRequired': 'Введите email',
      'passwordRequired': 'Введите пароль',
      'invalidEmail': 'Введите корректный email',
      'passwordTooShort': 'Пароль должен быть не менее 6 символов',
      'confirmPasswordRequired': 'Подтвердите пароль',
      'passwordsDoNotMatch': 'Пароли не совпадают',
      'noRecipes': 'У вас пока нет рецептов',
      'edit': 'Изменить',
      'language': 'Язык',
      'favorites': 'Избранное',
      'noFavorites': 'Нет избранных рецептов',
      'profile': 'Профиль',
      'logout': 'Выйти',
      'userNotFound': 'Пользователь не найден',
      'wrongPassword': 'Неверный пароль',
      'userDisabled': 'Аккаунт пользователя отключен',
      'networkError': 'Ошибка сети. Проверьте подключение',
      'resetPasswordEmailSent': 'Письмо для сброса пароля отправлено',
      'resetPasswordError': 'Не удалось отправить письмо для сброса пароля',
      'forgotPassword': 'Забыли пароль?',
    },
    'kk': {
      'appTitle': 'Тағамдар кітабы',
      'login': 'Кіру',
      'register': 'Тіркелу',
      'email': 'Email',
      'password': 'Құпия сөз',
      'confirmPassword': 'Құпия сөзді растау',
      'noAccount': 'Аккаунтыңыз жоқ па?',
      'hasAccount': 'Аккаунтыңыз бар ма?',
      'myRecipes': 'Менің тағамдарым',
      'addRecipe': 'Тағам қосу',
      'editRecipe': 'Тағамды өзгерту',
      'deleteRecipe': 'Тағамды жою',
      'ingredients': 'Ингредиенттер',
      'steps': 'Дайындау қадамдары',
      'save': 'Сақтау',
      'cancel': 'Болдырмау',
      'delete': 'Жою',
      'title': 'Атауы',
      'description': 'Сипаттама',
      'addPhoto': 'Фото қосу',
      'loginError': 'Кіру қатесі',
      'registerError': 'Тіркелу қатесі',
      'emailRequired': 'Email енгізіңіз',
      'passwordRequired': 'Құпия сөзді енгізіңіз',
      'invalidEmail': 'Дұрыс email енгізіңіз',
      'passwordTooShort': 'Құпия сөз кемінде 6 таңбадан тұруы керек',
      'confirmPasswordRequired': 'Құпия сөзді растаңыз',
      'passwordsDoNotMatch': 'Құпия сөздер сәйкес келмейді',
      'noRecipes': 'Сізде әлі тағам жоқ',
      'edit': 'Өзгерту',
      'language': 'Тіл',
      'favorites': 'Таңдаулылар',
      'noFavorites': 'Таңдаулы тағамдар жоқ',
      'profile': 'Профиль',
      'logout': 'Шығу',
      'userNotFound': 'Қолданушы табылмады',
      'wrongPassword': 'Қате құпия сөз',
      'userDisabled': 'Қолданушы аккаунты өшірілген',
      'networkError': 'Желі қатесі. Қосылымды тексеріңіз',
      'resetPasswordEmailSent': 'Құпия сөзді қалпына келтіру хаты жіберілді',
      'resetPasswordError': 'Құпия сөзді қалпына келтіру хатын жіберу сәтсіз',
      'forgotPassword': 'Құпия сөзді ұмыттыңыз ба?',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get confirmPassword => _localizedValues[locale.languageCode]!['confirmPassword']!;
  String get noAccount => _localizedValues[locale.languageCode]!['noAccount']!;
  String get hasAccount => _localizedValues[locale.languageCode]!['hasAccount']!;
  String get myRecipes => _localizedValues[locale.languageCode]!['myRecipes']!;
  String get addRecipe => _localizedValues[locale.languageCode]!['addRecipe']!;
  String get editRecipe => _localizedValues[locale.languageCode]!['editRecipe']!;
  String get deleteRecipe => _localizedValues[locale.languageCode]!['deleteRecipe']!;
  String get ingredients => _localizedValues[locale.languageCode]!['ingredients']!;
  String get steps => _localizedValues[locale.languageCode]!['steps']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get title => _localizedValues[locale.languageCode]!['title']!;
  String get description => _localizedValues[locale.languageCode]!['description']!;
  String get addPhoto => _localizedValues[locale.languageCode]!['addPhoto']!;
  String get loginError => _localizedValues[locale.languageCode]!['loginError']!;
  String get registerError => _localizedValues[locale.languageCode]!['registerError']!;
  String get emailRequired => _localizedValues[locale.languageCode]!['emailRequired']!;
  String get passwordRequired => _localizedValues[locale.languageCode]!['passwordRequired']!;
  String get invalidEmail => _localizedValues[locale.languageCode]!['invalidEmail']!;
  String get passwordTooShort => _localizedValues[locale.languageCode]!['passwordTooShort']!;
  String get confirmPasswordRequired => _localizedValues[locale.languageCode]!['confirmPasswordRequired']!;
  String get passwordsDoNotMatch => _localizedValues[locale.languageCode]!['passwordsDoNotMatch']!;
  String get noRecipes => _localizedValues[locale.languageCode]!['noRecipes']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get favorites => _localizedValues[locale.languageCode]!['favorites']!;
  String get noFavorites => _localizedValues[locale.languageCode]!['noFavorites']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get userNotFound => _localizedValues[locale.languageCode]!['userNotFound']!;
  String get wrongPassword => _localizedValues[locale.languageCode]!['wrongPassword']!;
  String get userDisabled => _localizedValues[locale.languageCode]!['userDisabled']!;
  String get networkError => _localizedValues[locale.languageCode]!['networkError']!;
  String get resetPasswordEmailSent => _localizedValues[locale.languageCode]!['resetPasswordEmailSent']!;
  String get resetPasswordError => _localizedValues[locale.languageCode]!['resetPasswordError']!;
  String get forgotPassword => _localizedValues[locale.languageCode]!['forgotPassword']!;
} 