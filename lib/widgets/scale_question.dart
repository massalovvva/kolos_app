import "package:flutter/material.dart";
import "package:kolos_app/theme/text_styles.dart";
import "package:kolos_app/theme/colors.dart";

class ScaleQuestion extends StatelessWidget {
  final String label;
  final String hint;
  final int? value;
  final ValueChanged<int> onChanged;

  const ScaleQuestion({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged
});

@override
Widget build(BuildContext context) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.questionLabel),
        const SizedBox(height: 2),
        Text(hint, style: AppTextStyles.questionHint),
        const SizedBox(height: 10),
        Row(
          children: List.generate(5, (index){
            final number = index +1;
            final isSelected = value == number;

            return Expanded(

              child: GestureDetector(
                onTap: () => onChanged(number),
                child: Container(
                  margin: EdgeInsets.only(right: number < 5 ? 8: 0),
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.accent : AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.white : AppColors.border,
                    ),
                  ),
                  child: Text(
                    '$number',
                    style: AppTextStyles.scaleNumber.copyWith(
                      color: isSelected
                        ? AppColors.background
                        : AppColors.textMuted,
                    ),
                  ),

                ),
              ),
            );


          }
          
          
          
          
          ),






        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Low", style: AppTextStyles.questionHint),
            Text("Great", style: AppTextStyles.questionHint),
          ],
        ),




      ],






  );











}




}

