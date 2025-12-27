import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/appbar.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Only ONE password rule
  final Map<String, bool> passwordCriteria = {"8 characters minimum": false};

  bool get _isConfirmPasswordValid =>
      _passwordController.text == _confirmPasswordController.text;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  ///Validate password length only
  void _validatePassword(String password) {
    setState(() {
      passwordCriteria["8 characters minimum"] = password.length >= 8;
    });
  }

  ///Form submit
  Future<void> _onResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final isValid =
        _passwordController.text.length >= 8 && _isConfirmPasswordValid;

    if (!isValid) return;

    context.push('/resetsuccess');

    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   final token = prefs.getString('password_token');

    //   final body = {
    //     "token": token,
    //     "password": _passwordController.text,
    //     "confirmPassword": _confirmPasswordController.text,
    //   };

    //   log("Reset Password Payload: $body");

    //   /// Call your API here
    //   // context.read<AuthProvider>().resetPassword(body);

    //   widget.onSwitchView("passwordresetsuccess");
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(e.toString())),
    //   );
    // }
  }

  ///Password validator
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context, 'Reset Password'),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: SvgPicture.asset('assets/svg/lock.svg'),
                ),
                const SizedBox(height: 10),

                /// Title
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                      letterSpacing: -0.5,
                      fontSize: getResponsiveFontSize(
                        context,
                        defaultFontSize: 25,
                        widePortraitFontSize: 20,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// Description
                Text(
                  "Set strong password with a combination of letters, numbers and special characters",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: getResponsiveFontSize(
                      context,
                      defaultFontSize: 15,
                      widePortraitFontSize: 12,
                    ),
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                /// New Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                    hintText: "Enter new password",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _validatePassword,
                  validator: _passwordValidator,
                ),

                const SizedBox(height: 16),

                /// Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm New Password",
                    hintText: "Re-enter new password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password is required";
                    }
                    if (!_isConfirmPasswordValid) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// ✅ Single criteria display
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: passwordCriteria.entries.map((entry) {
                    return Row(
                      children: [
                        Icon(
                          entry.value
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          size: 16,
                          color: entry.value ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(entry.key),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Confirm",
                    // isLoading: isLoading,
                    onPressed: _onResetPassword,

                    isEnabled: true,
                    color: AppColors.primaryColor,
                    textColor: AppColors.white,
                    defaultFontSize: 18,
                    widePortraitFontSize: 11,
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
