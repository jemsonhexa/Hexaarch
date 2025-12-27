import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';

class HexaCareersLayout extends StatefulWidget {
  const HexaCareersLayout({super.key});

  @override
  State<HexaCareersLayout> createState() => _HexaCareersLayoutState();
}

class _HexaCareersLayoutState extends State<HexaCareersLayout> {
  int _currentText = 0;
  final CarouselSliderController _textController = CarouselSliderController();
  final CarouselSliderController _imageController = CarouselSliderController();
  final List<Map<String, String>> carouselContent = [
    {
      "title": "Discover\nProperties",
      "content":
          "Browse verfied properties based on your location,budget, and preferences.",
    },
    {
      "title": "Place\nYour Bid",
      "content":
          "Choose a property and place your bid securely within the bidding window",
    },
    {
      "title": "Track\nLive Bids",
      "content":
          "See real-time bid updates and get notified when you're outbid.",
    },
    {
      "title": "Review &\nConfirm",
      "content":
          "Review property details , bid history, and payment terms before confirming",
    },
    {
      "title": "Win &\nProceed",
      "content":
          "If you win , complete the next steps like document verification and payment",
    },
  ];

  final List<String> carouselImages = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.png',
    'assets/images/carousel3.png',
    'assets/images/carousel4.png',
    'assets/images/carousel5.png',
  ];
  //MediaQuery.of(context).size.height * 0.07,

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        CarouselSlider(
          items: carouselImages.map((img) {
            return Stack(
              children: [
                Image.asset(
                  img,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ],
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            height: double.infinity,
            scrollPhysics: NeverScrollableScrollPhysics(),
            autoPlayCurve: Curves.ease,
          ),
          carouselController: _imageController,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                carouselController: _textController,
                itemCount: carouselContent.length,
                itemBuilder: (context, index, _) {
                  final item = carouselContent[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item['title']}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: getResponsiveFontSize(
                            context,
                            defaultFontSize: 30,
                            widePortraitFontSize: 14,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        item['content']!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: getResponsiveFontSize(
                            context,
                            defaultFontSize: 14,
                            widePortraitFontSize: 10,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1.05,
                  height: context.isTabLetPortrait ? 200 : 175,
                  autoPlay: true,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index, _) {
                    setState(() => _currentText = index);
                  },
                ),
              ),
              SizedBox(height: 20),
              //get started
              SizedBox(
                width: double.infinity,
                height: 55,
                child: CustomButton(
                  text: 'Get Started',
                  onPressed: () {
                    context.go('/phonesignin');
                  },
                  isEnabled: true,
                  color: AppColors.white,
                  textColor: Colors.blue,
                  defaultFontSize: 15,
                  widePortraitFontSize: 14,
                  borderRadius: 30,
                ),
              ),
              SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  carouselContent.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 5, top: 10),
                    height: 10,
                    width: _currentText == index ? 30 : 10,
                    decoration: BoxDecoration(
                      color: _currentText == index
                          ? Colors.blueAccent
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
