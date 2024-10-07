import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/EmailController/EmailController.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final String mail;
  final String provider;

  const AccountCard({
    super.key,
    required this.name,
    required this.mail,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    String providerAsset;
    switch (provider.toLowerCase()) {
      case 'google':
        providerAsset = 'assets/loginAssets/google.svg';
        break;
      case 'facebook':
        providerAsset = 'assets/loginAssets/Facebook.svg';
        break;
      case 'email':
        providerAsset = 'assets/loginAssets/Gmail.svg';
        break;
      default:
        providerAsset = 'assets/loginAssets/Gmail.svg';
        break;
    }

    return GestureDetector(
      onTap: () {
        Get.put(EmailController()).updateEmailAddress(mail);
        Get.offAllNamed('/signup');
      },
      child: Container(
        width: 252,
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 249, 250, 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(16, 24, 40, 0.06),
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
            BoxShadow(
              color: Color.fromRGBO(16, 24, 40, 0.1),
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              providerAsset,
              width: mail == 'email' ? 38.67 : 38,
              height: mail == 'email' ? 29 : 38,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color.fromRGBO(48, 48, 48, 1),
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  Text(
                    truncateEmail(mail),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color.fromRGBO(48, 48, 48, 1),
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String truncateEmail(String email) {
    List<String> emailParts = email.split('@');
    String namePart = emailParts[0];
    String domainPart = emailParts.length > 1 ? '@${emailParts[1]}' : '';
    if (namePart.length > 1) {
      String dots = '.' * (16 - domainPart.length);
      return '${namePart[0]}$dots$domainPart';
    } else {
      return email;
    }
  }
}
