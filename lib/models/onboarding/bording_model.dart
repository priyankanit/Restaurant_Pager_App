class BordingModel {
  String description;
  String image;

  BordingModel({required this.description, required this.image});

  static List<BordingModel> getOnBoardItem() {
    return [
      BordingModel(
        description: "Relax and enjoy your time we'll let you know when your table is ready",
        image: "assets/onboardingImg/onboarding1.png",
      ),
      BordingModel(
        description: "Raised a ticket and let us handle the rest. Your table is just a few taps away!",
        image: "assets/onboardingImg/onboarding2.png",
      ),
      BordingModel(
        description: "Receive real-time updates so you’ll always know when your order is ready.",
        image: "assets/onboardingImg/onboarding3.png",
      ),
    ];
  }
}
