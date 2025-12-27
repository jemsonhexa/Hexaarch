import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator; // Updated to accept a validator
  final TextStyle? labelStyle;
  final TextStyle? requiredIndicatorStyle;
  final String? errorText; // Added to show error text dynamically

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.validator,
    this.labelStyle = const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    this.requiredIndicatorStyle = const TextStyle(color: Colors.red),
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText,
            style: labelStyle,
            children: [TextSpan(text: ' *', style: requiredIndicatorStyle)],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(),

          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 239, 239, 240),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              errorText: errorText, // Added to display error text
            ),
            validator: validator, // Pass the validator to TextFormField
          ), // Pass the validator to TextFormField
        ),
      ],
    );
  }
}
