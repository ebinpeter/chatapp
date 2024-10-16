import 'package:chattick/core/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/media_query.dart';
import '../../../core/textstyle.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isRequired;
  final double height;
  final double width;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.isRequired = false,
    required this.height,
    required this.width, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: isRequired ? '$labelText (Required)' : labelText,
          hintStyle: style.FeildInput(context),
          filled: true,
          fillColor: Coloure.FeildColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
