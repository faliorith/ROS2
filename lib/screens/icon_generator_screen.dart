import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../utils/image_utils.dart';

class IconGeneratorScreen extends StatefulWidget {
  const IconGeneratorScreen({super.key});

  @override
  State<IconGeneratorScreen> createState() => _IconGeneratorScreenState();
}

class _IconGeneratorScreenState extends State<IconGeneratorScreen> {
  File? _selectedImage;
  bool _isProcessing = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _generateIcons() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, выберите изображение'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      // Создаем директорию, если её нет
      final directory = Directory('assets/icons');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Копируем исходное изображение
      final initialIcon = await _selectedImage!.copy('assets/icons/original_icon.png');
      
      // Генерируем иконки нужных размеров
      await ImageUtils.prepareAppIcons();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Иконки успешно сгенерированы'),
            backgroundColor: Colors.green,
          ),
        );
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
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Генератор иконок'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedImage != null)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Выбрать изображение'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isProcessing ? null : _generateIcons,
                child: _isProcessing
                    ? const CircularProgressIndicator()
                    : const Text('Сгенерировать иконки'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 