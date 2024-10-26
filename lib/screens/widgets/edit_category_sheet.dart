import 'package:flutter/material.dart';
import 'package:money_manager/models/models.dart';
import 'package:money_manager/models/money_usage.dart';

import 'beauty_text_field.dart';

class EditCategorySheet extends StatefulWidget {
  final void Function(Category category) onStartCounter;
  final void Function()? onDelete;
  final Category? category;
  const EditCategorySheet({
    super.key,
    required this.onStartCounter,
    this.category,
    this.onDelete,
  });

  @override
  State<EditCategorySheet> createState() => _EditCategorySheetState();
}

class _EditCategorySheetState extends State<EditCategorySheet> {
  final _form = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  late Category newCategory;

  @override
  void initState() {
    if (widget.category != null) {
      newCategory = widget.category!;
      _nameController.text = newCategory.name;
    } else {
      newCategory = Category(
        id: 'category-${DateTime.now().microsecondsSinceEpoch}',
        name: '',
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.category != null)
              IconButton(
                onPressed: widget.onDelete,
                icon: const Icon(Icons.delete),
              ),
            BeautyTextField(
              fieldName: 'اسم ألفئة',
              prefixIcon: const Icon(
                Icons.info_outline,
                color: Colors.grey,
              ),
              controller: _nameController,
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty) {
                  return;
                }
                Category category = newCategory.copyWith(
                  name: _nameController.text,
                );
                widget.onStartCounter(category);
              },
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
