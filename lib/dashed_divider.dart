import 'package:flutter/material.dart';
import 'package:kolos_app/theme/colors.dart';

class DashedDivider extends StatelessWidget {

  final double height;
  final Color color;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.color = AppColors.border,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const dashWidth = 6.0;
      const dashSpace = 6.0;
      final dashCount = 
                (constraints.maxWidth / (dashWidth + dashSpace)).floor();

      return Row(
        children: List.generate(dashCount, (_) {
          return Padding(padding: const EdgeInsets.only(right: dashSpace),
          child: Container(
            width: dashWidth,
            height: height,
            color: color,
            ),
          );
        }), 
        );
      },
    );

  }
}