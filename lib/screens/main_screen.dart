import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/search_bar.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'lunch';
  final List<Recipe> _recipes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .get();
      
      setState(() {
        _recipes.clear();
        _recipes.addAll(
          snapshot.docs.map((doc) => Recipe.fromFirestore(doc)).toList(),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Ошибка загрузки рецептов: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onSearchChanged(String query) {
    // Реализуйте поиск
  }

  void _onFilterTap() {
    // Реализуйте фильтрацию
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onFilterTap: _onFilterTap,
            ),
            CategorySelector(
              selectedCategory: _selectedCategory,
              onCategorySelected: _onCategorySelected,
            ),
            if (_isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_error != null)
              Expanded(
                child: Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _recipes.length,
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      recipe: _recipes[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/recipe_details',
                          arguments: _recipes[index],
                        ).then((_) => _loadRecipes());
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_recipe')
              .then((_) => _loadRecipes());
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
} 