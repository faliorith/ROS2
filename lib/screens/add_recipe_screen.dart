import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/recipe.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/recipe_service.dart';
import '../services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  
  File? _imageFile;
  int _difficulty = 1;
  List<String> _selectedTags = [];
  final List<String> _availableTags = [
    'завтрак', 'обед', 'ужин', 'десерт', 'суп', 
    'салат', 'выпечка', 'мясо', 'рыба', 'вегетарианское'
  ];
  String _cookingMethod = 'Запекание';
  final List<String> _cookingMethods = [
    'Запекание', 'Варка', 'Жарка', 'Тушение', 'Пароварка', 'Гриль'
  ];

  final _recipeService = RecipeService();
  final _authService = AuthService();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _cookingTimeController.dispose();
    _servingsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  void _addTag(String tag) {
    if (!_selectedTags.contains(tag)) {
      setState(() {
        _selectedTags.add(tag);
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _selectedTags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить рецепт'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveRecipe,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название блюда',
                  prefixIcon: Icon(Icons.restaurant_menu),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, добавьте описание';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDifficultySelector(),
              const SizedBox(height: 16),
              _buildCookingMethodSelector(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cookingTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Время приготовления (мин)',
                        prefixIcon: Icon(Icons.timer),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Укажите время';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _servingsController,
                      decoration: const InputDecoration(
                        labelText: 'Порций',
                        prefixIcon: Icon(Icons.people),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Укажите количество';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(
                  labelText: 'Ингредиенты',
                  prefixIcon: Icon(Icons.shopping_cart),
                  helperText: 'Введите каждый ингредиент с новой строки',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Добавьте ингредиенты';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                decoration: const InputDecoration(
                  labelText: 'Шаги приготовления',
                  prefixIcon: Icon(Icons.format_list_numbered),
                  helperText: 'Введите каждый шаг с новой строки',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Добавьте шаги приготовления';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTagSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          image: _imageFile != null
              ? DecorationImage(
                  image: FileImage(_imageFile!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Добавить фото',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildDifficultySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Сложность:',
          style: TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _difficulty = index + 1;
                });
              },
              child: Icon(
                Icons.circle,
                size: 24,
                color: index < _difficulty
                    ? AppTheme.accentColor
                    : AppTheme.tagBackgroundColor,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCookingMethodSelector() {
    return DropdownButtonFormField<String>(
      value: _cookingMethod,
      decoration: const InputDecoration(
        labelText: 'Способ приготовления',
        prefixIcon: Icon(Icons.whatshot),
      ),
      items: _cookingMethods.map((String method) {
        return DropdownMenuItem<String>(
          value: method,
          child: Text(method),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _cookingMethod = newValue;
          });
        }
      },
    );
  }

  Widget _buildTagSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Теги:',
          style: TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._selectedTags.map((tag) => Chip(
              label: Text(tag),
              onDeleted: () => _removeTag(tag),
              backgroundColor: AppTheme.tagBackgroundColor,
            )),
            ...(_availableTags
                .where((tag) => !_selectedTags.contains(tag))
                .map((tag) => ActionChip(
              label: Text(tag),
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade300),
              onPressed: () => _addTag(tag),
            ))),
          ],
        ),
      ],
    );
  }

  Future<void> _saveRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, добавьте изображение'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final user = _authService.currentUser;
      if (user == null) {
        throw Exception('Пользователь не авторизован');
      }

      // Загрузка изображения
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('recipe_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      await storageRef.putFile(_imageFile!);
      final imageUrl = await storageRef.getDownloadURL();

      // Создание рецепта
      final recipe = Recipe(
        id: '', // ID будет установлен Firestore
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: imageUrl,
        ingredients: _ingredientsController.text.split('\n'),
        steps: _stepsController.text.split('\n'),
        tags: _selectedTags,
        rating: 0.0,
        difficulty: _difficulty,
        cookingTime: int.parse(_cookingTimeController.text),
        servings: int.parse(_servingsController.text),
        cookingMethod: _cookingMethod,
      );

      // Сохранение в Firestore
      await _recipeService.addRecipe(recipe);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Рецепт успешно добавлен'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 