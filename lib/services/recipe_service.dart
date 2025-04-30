// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'recipes';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Recipe>> getRecipes(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Recipe.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      print('Ошибка получения рецептов: $e');
      return [];
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Пользователь не авторизован');
      
      final recipeData = recipe.toMap();
      recipeData['userId'] = user.uid;
      recipeData['createdAt'] = FieldValue.serverTimestamp();
      
      await _firestore.collection(_collection).add(recipeData);
    } catch (e) {
      throw Exception('Ошибка при добавлении рецепта: $e');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      final recipeData = recipe.toMap();
      recipeData['updatedAt'] = FieldValue.serverTimestamp();
      
      await _firestore
          .collection(_collection)
          .doc(recipe.id)
          .update(recipeData);
    } catch (e) {
      throw Exception('Ошибка при обновлении рецепта: $e');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _firestore.collection(_collection).doc(recipeId).delete();
    } catch (e) {
      throw Exception('Ошибка при удалении рецепта: $e');
    }
  }
} 