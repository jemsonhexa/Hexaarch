import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/views/auth/signup/provider/location_provider.dart';
import 'package:hexaarch/views/auth/signup/provider/name_provider.dart';
import 'package:hexaarch/views/auth/signup/provider/pic_provider.dart';

class ShowProfile extends ConsumerStatefulWidget {
  const ShowProfile({super.key});

  @override
  ConsumerState<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends ConsumerState<ShowProfile> {
  @override
  Widget build(BuildContext context) {
    final selectedImage = ref.watch(picProvider);
    final name = ref.watch(nameProvider);
    final location = ref.watch(locProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// Title
            const Text(
              'Nice!, how your profile is looking so far',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 40),
            selectedImage != null
                ? ClipOval(
                    child: Image.file(
                      selectedImage,
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  )
                : Image.asset(
                    'assets/images/nopic.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 16),

            /// name
            Text(
              name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            Text(
              location!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 15, height: 1.4),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/propertytype');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
