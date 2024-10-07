import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/views/LinkAccountPage/components/AccountCard.dart';

// const List<AccountCard> exampleAccounts = [
//   AccountCard(
//     name: "John Doe",
//     mail: "johndoe@gmail.com",
//     provider: "google",
//   ),
//   AccountCard(
//     name: "Jane Smith",
//     mail: "janesmith@yahoo.com",
//     provider: "facebook",
//   ),
//   AccountCard(
//     name: "Michael Johnson",
//     mail: "mjohnson@hotmail.com",
//     provider: "email",
//   ),
// ];


class LinkAccountPage extends StatelessWidget {
  final List<AccountCard> accounts;
  const LinkAccountPage({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        title: Text(
          "Link Account",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            height: 1.3,
            color: const Color.fromRGBO(30, 30, 30, 1),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 30),
          onPressed: () => Get.offAllNamed('/login'),
          icon: SvgPicture.asset(
            'assets/loginAssets/arrow_left_alt.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 22,),
            Text(
              'We have detected multiple accounts linked to\n your phone number. For security reasons, please\n verify the account below to continue',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: const Color.fromRGBO(20, 28, 36, 1),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40 - 12,
            ),
            for (final account in accounts)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: account,
              ),
            const SizedBox(
              height: 26 - 12,
            ),
            TextButton(
              onPressed: () => Get.offAllNamed('/signup'),
              child: Text(
                "Create New account",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  height: 22/14,
                  color:const Color.fromRGBO(30, 30, 30, 1)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}