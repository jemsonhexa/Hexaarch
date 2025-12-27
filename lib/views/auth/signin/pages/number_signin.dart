import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/inputfields/textfield.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';
import 'package:hexaarch/views/auth/signup/provider/phone_num_provider.dart';
import 'package:hexaarch/views/auth/signin/widgets/signin_buttons.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneSignInScreen extends ConsumerStatefulWidget {
  const PhoneSignInScreen({super.key});

  @override
  ConsumerState<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends ConsumerState<PhoneSignInScreen> {
  late final TextEditingController _phoneController;
  final _signinWithNumberFormKey = GlobalKey<FormState>();

  String _selectedCountry = 'India (+91)';
  bool isTextNotEmpty = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneController.addListener(_handlePhoneInputChange);
  }

  void _handlePhoneInputChange() {
    setState(() {
      isTextNotEmpty = _phoneController.text.length == 10;
    });
  }

  @override
  void dispose() {
    _phoneController.removeListener(_handlePhoneInputChange);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _signinWithNumberFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Country / Region
              Text(
                'Country / Region',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: -0.5,
                  fontSize: getResponsiveFontSize(
                    context,
                    defaultFontSize: 12,
                    widePortraitFontSize: 10,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedCountry,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'India (+91)',
                    child: Text('India (+91)'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              /// Phone Number
              CustomEditTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                hintText: 'Enter your mobile number',
                keyBoardType: TextInputType.number,
                inputformatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: -0.5,
                  fontSize: getResponsiveFontSize(
                    context,
                    defaultFontSize: 12,
                    widePortraitFontSize: 10,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.length != 10) {
                    return 'Enter valid 10 digit number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8),

              Text(
                'We call or text you to confirm your number. '
                'Standard message and data rates may apply.',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 24),

              /// Continue Button
              CustomButton(
                text: 'Continue',
                isLoading: isLoading,
                isEnabled: isTextNotEmpty,
                color: AppColors.primaryColor,
                textColor: AppColors.white,
                defaultFontSize: 18,
                widePortraitFontSize: 12,
                borderRadius: 8,
                onPressed: () async {
                  if (!_signinWithNumberFormKey.currentState!.validate()) {
                    return;
                  }

                  setState(() => isLoading = true);

                  // Save phone number with country code
                  ref
                      .read(phoneNumberProvider.notifier)
                      .setPhone('+91${_phoneController.text}');

                  await Future.delayed(const Duration(seconds: 2));

                  setState(() => isLoading = false);

                  if (context.mounted) {
                    context.push('/otp');
                  }
                },
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Or',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(height: 20),

              /// Social Login Buttons
              googleSignInButton(context),
              const SizedBox(height: 10),
              fbSignInButton(context),
              const SizedBox(height: 10),
              emailSignInButton(context),
              const SizedBox(height: 10),
              appleSignInButton(context),
              const SizedBox(height: 10),
              //signup
              signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
