import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/onboarding/bording_model.dart';
import 'package:flutter/material.dart';

class BoardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs; 

  List<BordingModel> onboardingItems = BordingModel.getOnBoardItem();

  void nextPage() {
    if (currentPage.value < onboardingItems.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    else{
      // Get.to(()=> HomeScreen()); // added the nextPage LOGIC
    }
  }

  void onPageChanged(int page) {
    currentPage.value = page; 
  }
}
