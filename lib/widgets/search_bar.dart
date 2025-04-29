import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onFilterTap;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.search, color: AppTheme.secondaryTextColor),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Поиск рецептов...',
                hintStyle: const TextStyle(color: AppTheme.secondaryTextColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppTheme.secondaryTextColor),
                        onPressed: () {
                          controller.clear();
                          onChanged('');
                        },
                      )
                    : null,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: AppTheme.primaryColor),
            onPressed: onFilterTap,
          ),
        ],
      ),
    );
  }
} 