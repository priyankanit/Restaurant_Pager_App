import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/dateField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/emailField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/genderField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/messagePerference.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/nameField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/phoneNoField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/profilePic.dart';
import 'package:restuarant_pager_app/views/VerifyEmailUsingOTP/VerifyEmailUsingOTP.dart';
import 'package:restuarant_pager_app/widgets/TermsAndConditions.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final SignUpController controller = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
        Get.to(VerifyEmailUsingOTP(onVerified: (){controller.submit(context);}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0, vertical: 33.0),
          child: Text(
            "Personal Details",
            style: GoogleFonts.inter(
              color: fontColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.21,
            ),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, 
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 272,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Center(
                    child: ProfilePic(),
                  ),
                  const SizedBox(height: 16),
                  // Name section
                  const NameField(),
                  const SizedBox(height: 16),
                  // DOB section
                  const DateField(),                  
                  const SizedBox(height: 16),
                  // Gender section
                  const GenderField(),
                  const SizedBox(height: 16),
                  // Phone Number section
                  const PhoneNoField(),  
                  const SizedBox(height: 16),
                  // Email section
                  const EmailField(),
                  const SizedBox(height: 30),
                  // WhatsApp perference section --> checkbox
                  const MessagePerference(),
                  const SizedBox(height: 30),
                  // Create Account Button
                  Button(onPressed: _submitForm, text: "Create account"),
                  const SizedBox(height: 30),
                  // Terms & conditions
                  const Center(
                    child: TermsAndConditons(),
                  ),
                  const SizedBox(height: 16,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
