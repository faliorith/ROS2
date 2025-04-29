import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String selectedCategory;

  const CategorySelector({
    super.key,
    required this.onCategorySelected,
    required this.selectedCategory,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> categories = ['breakfast', 'lunch', 'dinner', 'desserts'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == widget.selectedCategory;

          return GestureDetector(
            onTap: () => widget.onCategorySelected(category),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category[0].toUpperCase() + category.substring(1),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 