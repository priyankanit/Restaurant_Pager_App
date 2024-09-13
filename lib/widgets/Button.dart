import 'package:flutter/material.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool disable;
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.disable = false,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: TextButton(
        onPressed: widget.disable?null: widget.onPressed,
        onHover: (value) {
        },
        style: TextButton.styleFrom(
          disabledBackgroundColor: const Color.fromRGBO(247, 249, 250, 1),
          disabledForegroundColor: fontColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: themeColor,
          foregroundColor:Colors.white,
        ),
        child:Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.21
          ),
        ),
      ),
    );
  }
}
