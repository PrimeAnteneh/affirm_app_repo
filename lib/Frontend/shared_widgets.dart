import 'package:affirm/Frontend/shared_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? gradientColor1;
  final Color? gradientColor2;
  final Color? borderColor;
  final IconData? icon;
  final double? iconSize;
  final double? borderSize;
  final bool? border;
  const CustomButton(
      {Key? key,
      this.gradientColor1,
      this.gradientColor2,
      this.icon,
      this.iconSize,
      this.border,
      this.borderColor,
      this.borderSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = PrimaryColors();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            gradientColor1 ?? colors.green,
            gradientColor2 ?? colors.blue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: borderColor ?? colors.shadeSide,
          width: borderSize ?? 5,
        ),
      ),
      child: Center(
        child: Icon(
          icon ?? Icons.warning,
          size: iconSize ?? 20,
          color: Colors.grey[200]!,
        ),
      ),
    );
  }
}
