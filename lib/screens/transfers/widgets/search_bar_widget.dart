import 'package:app_b_804/app_resource/app_images.dart';
import 'package:app_b_804/app_resource/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../app_resource/app_colors.dart';
import '../../../app_resource/app_strings.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onClear;
  final bool isFocused;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.onTap,
    required this.controller,
    required this.focusNode,
    required this.onClear,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 16, left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              maxLength: 20,
              style: AppTextStyles.header14,
              cursorColor: AppColors.buttonBackgroundColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Image.asset(
                    AppImages.iconSearch,
                    width: 20,
                    height: 20,
                    color: isFocused ? AppColors.indecatorColor : null,
                  ),
                ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: hasText
                    ? IconButton(
                        icon: Image.asset(
                          AppImages.iconClear,
                          width: 16,
                          height: 16,
                        ),
                        onPressed: onClear,
                      )
                    : null,
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                hintText: AppStrings.hintText,
                hintStyle: AppTextStyles.header14.copyWith(
                  color: AppColors.hinitText,
                ),
                labelStyle: AppTextStyles.header16,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.indecatorColor),
                ),
                filled: true,
                fillColor: AppColors.searchBarColor,
              ),
            ),
          ),
          if (!isFocused) ...[
            const SizedBox(width: 13),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 48,
                width: 48,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.searchBarColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(AppImages.filterIcon),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
