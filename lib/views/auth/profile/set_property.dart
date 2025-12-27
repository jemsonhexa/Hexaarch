import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/appbar.dart';
import 'package:hexaarch/themes/color_scheme.dart';

class PropertyTypeScreen extends StatefulWidget {
  const PropertyTypeScreen({super.key});

  @override
  State<PropertyTypeScreen> createState() => _PropertyTypeScreenState();
}

class _PropertyTypeScreenState extends State<PropertyTypeScreen> {
  final List<String> propertyTypes = [
    'Apartment',
    'Flat',
    'Villa',
    'Independent House',
    'Land / Plot',
    'Commercial Property',
    'Not sure yet',
  ];

  final Set<String> selectedTypes = {'Flat', 'Villa', 'Land / Plot'};

  void toggleSelection(String type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
      } else {
        selectedTypes.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context, 'Property'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentGeometry.center,
              child: const Text(
                'Type of property',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: AlignmentGeometry.center,
              child: const Text(
                'Type of property you are interested in?',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            // List
            Expanded(
              child: ListView.separated(
                itemCount: propertyTypes.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final type = propertyTypes[index];
                  final isSelected = selectedTypes.contains(type);

                  return GestureDetector(
                    onTap: () => toggleSelection(type),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.blue : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => toggleSelection(type),
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: selectedTypes.isEmpty
                    ? null
                    : () {
                        // Handle navigation / save
                        debugPrint(selectedTypes.toString());
                        context.push('/budgetrange');
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
