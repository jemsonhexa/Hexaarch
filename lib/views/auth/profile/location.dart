import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/inputfields/textfield.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/views/auth/signup/provider/location_provider.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(), // GoRouter friendly
        ),
        title: const Text("Location"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              const Icon(Icons.location_pin, size: 80, color: Colors.redAccent),
              const SizedBox(height: 20),

              const Text(
                "What’s your location?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              const Text(
                "Find your dream home near your location",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              CustomEditTextField(
                controller: _locationController,
                labelText: 'Location',
                hintText: 'Enter your location',
                keyBoardType: TextInputType.name,
                validator: (val) => val == null || val.trim().isEmpty
                    ? "Location is required"
                    : null,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(locProvider.notifier)
                          .setLocation(_locationController.text);
                      context.push('/profilepic');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
