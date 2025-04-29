import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;
  final _recipeService = RecipeService();

  RecipeDetailsScreen({super.key, required this.recipe});

  Future<void> _deleteRecipe(BuildContext context) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Удалить рецепт'),
          content: const Text('Вы уверены, что хотите удалить этот рецепт?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Удалить'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await _recipeService.deleteRecipe(recipe.id);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при удалении: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/edit_recipe',
                arguments: recipe,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteRecipe(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              recipe.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Ингредиенты:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((ingredient) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Text('• $ingredient'),
                )),
            const SizedBox(height: 16),
            const Text(
              'Шаги приготовления:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...recipe.steps.asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Text('${entry.key + 1}. ${entry.value}'),
                )),
          ],
        ),
      ),
    );
  }
} 