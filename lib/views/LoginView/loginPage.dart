import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_pager/constants/ColorPalette.dart';
import 'package:restaurant_pager/views/LoginView/components/googleSignInButton.dart';
import 'package:restaurant_pager/views/LoginView/components/phoneNoField.dart';
import 'package:restaurant_pager/widgets/TermsAndConditions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Upper SVG Image
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                        child: SvgPicture.asset("assets/loginAssets/Group.svg", fit: BoxFit.cover),
                      ),
                    ),
                    const Spacer(),
                    // main container
                    Container(
                      height: 417,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(247, 249, 250, 1),
                        borderRadius: BorderRadius.vertical(top: Radius.elliptical(200, 15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 34),
                            Text(
                              "Log in or Sign up",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: fontColor,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            const SizedBox(height: 34),
                            // [Country Dropdown + Phone Input] + Continue Button
                            const PhoneNoField(),
                            const SizedBox(height: 34),
                            // --- or ---
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Color.fromRGBO(216, 218, 220, 1),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Text(
                                    "Or",
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        height: 1.21,
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Color.fromRGBO(216, 218, 220, 1),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 31),
                            // google sign in button
                            const GoogleSignInButton(),
                            const SizedBox(height: 31),
                            //terms and conditions
                            const TermsAndConditons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
