

// import 'package:flutter/material.dart';

// class CustomPasswordField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String? labelText;
//   final String? errorText; // Error text to display below the field
//   final String? Function(String?)? validator; // Updated to accept a validator
//   final bool isRequired;
//   final Function(String)? onTextChanged;

//   const CustomPasswordField({
//     super.key,
//     required this.controller,
//     this.validator,
//     this.errorText,
//     this.hintText = 'Enter your Password',
//     this.labelText,
//     this.isRequired = false,
//     this.onTextChanged,
//   });

//   @override
//   _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
// }

// class _CustomPasswordFieldState extends State<CustomPasswordField> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: '${widget.labelText} ',
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//             children: widget.isRequired
//                 ? [
//                     TextSpan(
//                       text: '*',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ]
//                 : [],
//           ),
//         ),
//         const SizedBox(height: 5),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: _obscureText,
//           onChanged: widget.onTextChanged,
//           decoration: InputDecoration(
//             hintText: widget.hintText,
//             hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontSize: 12,
//                 ),
            
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(24.0),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             fillColor: const Color.fromARGB(255, 239, 239, 240),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12.0,
//               vertical: 8.0,
//             ),
//             suffixIcon: IconButton(
//               color: Colors.grey,
//               icon: Icon(
//                 _obscureText ? Icons.visibility_off : Icons.visibility,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//             ),
//                         errorText: widget.errorText, // Error text displayed within the InputDecoration

//           ),
//           validator: widget.validator, // Pass the validator to TextFormField
//         ),
//       ],
//     );
//   }
// }
