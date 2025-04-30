// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    try {
      print('Начало процесса входа для email: $email');
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Получаем данные пользователя из Firestore
      final userDoc = await _firestore.collection('users').doc(userCredential.user?.uid).get();
      if (!userDoc.exists) {
        throw Exception('Данные пользователя не найдены');
      }
      
      print('Пользователь успешно вошел: ${userCredential.user?.uid}');
      await setLoggedIn(true);
      print('Статус авторизации установлен');
    } on FirebaseAuthException catch (e) {
      print('Ошибка Firebase Auth: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          throw Exception('Пользователь не найден');
        case 'wrong-password':
          throw Exception('Неверный пароль');
        case 'invalid-email':
          throw Exception('Неверный формат email');
        case 'user-disabled':
          throw Exception('Аккаунт отключен');
        case 'network-request-failed':
          throw Exception('Ошибка сети');
        default:
          throw Exception('Ошибка входа: ${e.message}');
      }
    } catch (e) {
      print('Общая ошибка входа: $e');
      throw Exception('Ошибка входа: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      print('Начало процесса регистрации для email: $email');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        createdAt: DateTime.now(),
      );
      
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      print('Данные пользователя сохранены в Firestore');
      
      await setLoggedIn(true);
      print('Статус авторизации установлен');
    } on FirebaseAuthException catch (e) {
      print('Ошибка Firebase Auth: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'weak-password':
          throw Exception('Слишком слабый пароль');
        case 'email-already-in-use':
          throw Exception('Email уже используется');
        case 'invalid-email':
          throw Exception('Неверный формат email');
        case 'operation-not-allowed':
          throw Exception('Регистрация отключена');
        case 'network-request-failed':
          throw Exception('Ошибка сети');
        default:
          throw Exception('Ошибка регистрации: ${e.message}');
      }
    } catch (e) {
      print('Общая ошибка регистрации: $e');
      throw Exception('Ошибка регистрации: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await setLoggedIn(false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  void navigateToMain(BuildContext context) {
    if (_auth.currentUser != null) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      throw Exception('Пользователь не авторизован');
    }
  }
} 