import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/onboarding/boarding_controller.dart';
import 'package:restuarant_pager_app/models/onboarding/bording_model.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BoardingController controller = Get.put(BoardingController()); // Inject controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 199, 169, 0.5),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(299, 120),
                    bottomLeft: Radius.elliptical(299, 120)),
              ),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.onboardingItems.length,
                onPageChanged: controller.onPageChanged, // Update current page
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(item: controller.onboardingItems[index]);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(controller),
                      )),
                  SizedBox(
                      width: 273,
                      height: 102,
                      child: Obx(() => OnboardingItemDescription(
                          item: controller.onboardingItems[controller.currentPage.value]))),
                  GestureDetector(
                    onTap: controller.nextPage, // Move to the next page
                    child: Container(
                      width: 283,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffFD4712),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(() => Text(
                            controller.currentPage.value < controller.onboardingItems.length - 1
                                ? 'Next'
                                : "Get Started",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator(BoardingController controller) {
    List<Widget> list = [];
    for (int i = 0; i < controller.onboardingItems.length; i++) {
      list.add(i == controller.currentPage.value
          ? _indicator(true)
          : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      height: 8.0,
      width: isActive ? 16.0 : 37.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF5C00) : Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnboardingItemWidget extends StatelessWidget {
  final BordingModel item;

  const OnboardingItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          item.image,
          filterQuality: FilterQuality.medium,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}

class OnboardingItemDescription extends StatelessWidget {
  final BordingModel item;

  const OnboardingItemDescription({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Text(
      item.description,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
    );
  }
}