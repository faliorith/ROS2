part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final bool isLoading;
  final String? error;

  const RecipeState({
    this.recipes = const [],
    this.isLoading = false,
    this.error,
  });

  RecipeState copyWith({
    List<Recipe>? recipes,
    bool? isLoading,
    String? error,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [recipes, isLoading, error];
} 