import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tags;
  final double rating;
  final int difficulty;
  final int cookingTime;
  final int servings;
  final String cookingMethod;
  bool isFavorite;
  final String userId;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.tags,
    required this.rating,
    required this.difficulty,
    required this.cookingTime,
    required this.servings,
    required this.cookingMethod,
    this.isFavorite = false,
    required this.userId,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? steps,
    List<String>? tags,
    double? rating,
    int? difficulty,
    int? cookingTime,
    int? servings,
    String? cookingMethod,
    bool? isFavorite,
    String? userId,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      difficulty: difficulty ?? this.difficulty,
      cookingTime: cookingTime ?? this.cookingTime,
      servings: servings ?? this.servings,
      cookingMethod: cookingMethod ?? this.cookingMethod,
      isFavorite: isFavorite ?? this.isFavorite,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'steps': steps,
      'tags': tags,
      'rating': rating,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
      'servings': servings,
      'cookingMethod': cookingMethod,
      'isFavorite': isFavorite,
      'userId': userId,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      steps: List<String>.from(map['steps'] ?? []),
      tags: List<String>.from(map['tags'] ?? []),
      rating: (map['rating'] as num).toDouble(),
      difficulty: map['difficulty'] as int,
      cookingTime: map['cookingTime'] as int,
      servings: map['servings'] as int,
      cookingMethod: map['cookingMethod'] as String,
      isFavorite: map['isFavorite'] as bool? ?? false,
      userId: map['userId'] ?? '',
    );
  }

  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Recipe(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
      ingredients: List<String>.from(data['ingredients']),
      steps: List<String>.from(data['steps']),
      tags: List<String>.from(data['tags']),
      rating: (data['rating'] as num).toDouble(),
      difficulty: data['difficulty'] as int,
      cookingTime: data['cookingTime'] as int,
      servings: data['servings'] as int,
      cookingMethod: data['cookingMethod'] as String,
      isFavorite: data['isFavorite'] as bool? ?? false,
      userId: data['userId'] as String,
    );
  }
} 