import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/recipe.dart';
import '../../services/recipe_service.dart';
import '../../services/auth_service.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeService _recipeService;
  final AuthService _authService;

  RecipeBloc({
    required RecipeService recipeService,
    required AuthService authService,
  })  : _recipeService = recipeService,
        _authService = authService,
        super(const RecipeState()) {
    on<LoadRecipes>(_onLoadRecipes);
    on<AddRecipe>(_onAddRecipe);
    on<UpdateRecipe>(_onUpdateRecipe);
    on<DeleteRecipe>(_onDeleteRecipe);
  }

  Future<void> _onLoadRecipes(LoadRecipes event, Emitter<RecipeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final recipes = await _recipeService.getRecipes(user.uid);
        emit(state.copyWith(recipes: recipes, isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onAddRecipe(AddRecipe event, Emitter<RecipeState> emit) async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final recipe = event.recipe.copyWith(userId: user.uid);
        await _recipeService.addRecipe(recipe);
        add(LoadRecipes());
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onUpdateRecipe(UpdateRecipe event, Emitter<RecipeState> emit) async {
    try {
      await _recipeService.updateRecipe(event.recipe);
      add(LoadRecipes());
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onDeleteRecipe(DeleteRecipe event, Emitter<RecipeState> emit) async {
    try {
      await _recipeService.deleteRecipe(event.recipeId);
      add(LoadRecipes());
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
} 