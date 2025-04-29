import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final bool isDetailed;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.isDetailed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                recipe.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: recipe.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          // Добавить обработку избранного
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (isDetailed) ...[
                    _buildRating(recipe.rating),
                    const SizedBox(height: 12),
                    _buildTags(recipe.tags),
                    const SizedBox(height: 16),
                    _buildDifficulty(recipe.difficulty),
                    const SizedBox(height: 16),
                    Text(
                      recipe.description,
                      style: const TextStyle(
                        color: AppTheme.secondaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildIngredients(recipe.ingredients),
                    const SizedBox(height: 16),
                    _buildCookingInfo(recipe),
                  ] else ...[
                    Text(
                      recipe.ingredients.join(', '),
                      style: const TextStyle(
                        color: AppTheme.secondaryTextColor,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 20,
          );
        }),
        const SizedBox(width: 8),
        Text(
          '${rating.toString()} / 5.0',
          style: const TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTags(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Chip(
          label: Text(tag),
          backgroundColor: AppTheme.tagBackgroundColor,
        );
      }).toList(),
    );
  }

  Widget _buildDifficulty(int difficulty) {
    return Row(
      children: [
        const Text(
          'Сложность: ',
          style: TextStyle(
            color: AppTheme.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        ...List.generate(5, (index) {
          return Icon(
            Icons.circle,
            size: 12,
            color: index < difficulty
                ? AppTheme.accentColor
                : AppTheme.tagBackgroundColor,
          );
        }),
      ],
    );
  }

  Widget _buildIngredients(List<String> ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ингредиенты:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        ...ingredients.map((ingredient) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.fiber_manual_record, size: 8),
                const SizedBox(width: 8),
                Text(
                  ingredient,
                  style: const TextStyle(
                    color: AppTheme.secondaryTextColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCookingInfo(Recipe recipe) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoItem(Icons.timer, '${recipe.cookingTime} мин'),
        _buildInfoItem(Icons.restaurant, '${recipe.servings} порций'),
        _buildInfoItem(Icons.whatshot, recipe.cookingMethod),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentColor),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 