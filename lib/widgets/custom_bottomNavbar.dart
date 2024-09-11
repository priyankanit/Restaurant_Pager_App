import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/views/main_screens/scanner_screen/scanner_screen.dart';
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: -6,
            child: _buildScannerButton(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('assets/images/li_home.png', "Home", 0),
              const SizedBox(width: 0),
              _buildNavItem('assets/images/shopping-cart.png', "History", 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String imagePath, String label, int index) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath,
              color: isSelected
                  ? const Color(0xffFE6E39)
                  : const Color(0xff484C52)),
              const SizedBox(height: 4,),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xffFE6E39)
                  : const Color(0xff484C52),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerButton() {
    return GestureDetector(
      onTap: () {
        Get.to(const ScannerScreen());
        print("object");
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 5),
          color: Color(0xffFE6E39),
        ),
        child: Image.asset("assets/images/scan.png"),
      ),
    );
  }
}
