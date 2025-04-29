// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'recipes';

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
      await _firestore.collection(_collection).add(recipe.toMap());
    } catch (e) {
      print('Ошибка добавления рецепта: $e');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(recipe.id)
          .update(recipe.toMap());
    } catch (e) {
      print('Ошибка обновления рецепта: $e');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _firestore.collection(_collection).doc(recipeId).delete();
    } catch (e) {
      print('Ошибка удаления рецепта: $e');
    }
  }
} 