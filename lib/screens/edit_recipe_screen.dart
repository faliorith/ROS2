import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../models/recipe.dart';
import '../bloc/recipe/recipe_bloc.dart';
import '../l10n/app_localizations.dart';

class EditRecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const EditRecipeScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late List<TextEditingController> _ingredientControllers;
  late List<TextEditingController> _stepControllers;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _descriptionController = TextEditingController(text: widget.recipe.description);
    _ingredientControllers = widget.recipe.ingredients
        .map((ingredient) => TextEditingController(text: ingredient))
        .toList();
    _stepControllers = widget.recipe.steps
        .map((step) => TextEditingController(text: step))
        .toList();
    _imageUrl = widget.recipe.imageUrl;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _stepControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageUrl = pickedFile.path;
      });
    }
  }

  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientControllers[index].dispose();
      _ingredientControllers.removeAt(index);
    });
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }

  void _removeStep(int index) {
    setState(() {
      _stepControllers[index].dispose();
      _stepControllers.removeAt(index);
    });
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final updatedRecipe = Recipe(
        id: widget.recipe.id,
        title: _titleController.text,
        description: _descriptionController.text,
        ingredients: _ingredientControllers
            .map((controller) => controller.text)
            .where((text) => text.isNotEmpty)
            .toList(),
        steps: _stepControllers
            .map((controller) => controller.text)
            .where((text) => text.isNotEmpty)
            .toList(),
        imageUrl: _imageUrl ?? '',
        userId: widget.recipe.userId,
        tags: widget.recipe.tags, 
        rating: widget.recipe.rating, // Add appropriate value for rating
        difficulty: widget.recipe.difficulty, // Add appropriate value for difficulty
        cookingTime: widget.recipe.cookingTime, // Add appropriate value for cookingTime
        servings: widget.recipe.servings, // Add appropriate value for servings
        cookingMethod: widget.recipe.cookingMethod, // Add appropriate value for cookingMethod
      );

      context.read<RecipeBloc>().add(UpdateRecipe(updatedRecipe));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.editRecipe),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveRecipe,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: localizations.title,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.pleaseEnterTitle.toString();
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: localizations.description,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localizations.pleaseEnterDescription.toString();
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            if (_imageUrl != null && _imageUrl!.isNotEmpty)
              Image.network(
                _imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: Text(localizations.pickImage),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.ingredients,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ..._ingredientControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: '${localizations.ingredient} ${index + 1}',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removeIngredient(index),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _addIngredient,
              icon: const Icon(Icons.add),
              label: Text(localizations.addIngredient),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.steps,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ..._stepControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: '${localizations.steps} ${index + 1}',
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removeStep(index),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _addStep,
              icon: const Icon(Icons.add),
              label: Text(localizations.addStep),
            ),
          ],
        ),
      ),
    );
  }
} 