import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/appbar.dart';
import 'package:hexaarch/constants/snackbar.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/views/auth/signup/provider/pic_provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoPage extends ConsumerStatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  ConsumerState<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends ConsumerState<ProfilePhotoPage> {
  File? selectedImage;
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      ref.read(picProvider.notifier).setPic(selectedImage!);
    }
  }

  Future<void> imgSelected() async {
    selectedImage != null
        ? context.push('/showprofile')
        : customshowSnackBar(context, "Please select image", Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppbar(context, 'Profile'),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// Title
            const Text(
              'Adding photo to make your profile\nstuning',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: pickImage,
              child: selectedImage != null
                  ? ClipOval(
                      child: Image.file(
                        selectedImage!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
            ),

            const SizedBox(height: 16),

            /// Subtitle
            const Text(
              'Click above to upload profile picture.\n'
              'Recommended Size 512×512px',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const Spacer(),

            /// Add Photo Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: imgSelected,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add photo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            /// Skip Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  context.push('/showprofile');
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
