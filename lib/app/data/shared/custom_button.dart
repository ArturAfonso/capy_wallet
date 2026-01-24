// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
  final BorderRadiusGeometry borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? icon;

  const CustomButton({
    required this.text,
    super.key,
    this.width = double.infinity,
    this.height = 55.0,
    this.onPressed,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(24.0)),
    this.backgroundColor,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Largura configurável
      height: height, // Altura configurável
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: onPressed != null ? (borderColor ?? Theme.of(context).colorScheme.primary) : Colors.transparent),
          ),
        ),
        onPressed:
            onPressed,
        child:
            icon == null
                ? Text(
                  text,
                  style:
                      textStyle ??
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                )
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    const SizedBox(width: 8),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style:
                          textStyle ??
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
      ),
    );
  }
}
