import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import '../models/category_model.dart';
import '../utils/app_colors.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Function(Category) onCategorySelected;

  CategoryList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(category.name, style: AppTextStyles.displayMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
