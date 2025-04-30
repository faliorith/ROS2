part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipes extends RecipeEvent {}

class AddRecipe extends RecipeEvent {
  final Recipe recipe;

  const AddRecipe(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class UpdateRecipe extends RecipeEvent {
  final Recipe recipe;

  const UpdateRecipe(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class DeleteRecipe extends RecipeEvent {
  final String recipeId;

  const DeleteRecipe(this.recipeId);

  @override
  List<Object> get props => [recipeId];
} 