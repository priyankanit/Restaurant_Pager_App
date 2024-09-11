import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_pager/controllers/EditProfileController/EditProfileController.dart';
import 'package:restaurant_pager/views/EditProfileView/components/EditProfileDateField.dart';
import 'package:restaurant_pager/views/EditProfileView/components/EditProfileEmailField.dart';
import 'package:restaurant_pager/views/EditProfileView/components/EditProfileGenderField.dart';
import 'package:restaurant_pager/views/EditProfileView/components/EditProfileNameField.dart';
import 'package:restaurant_pager/views/EditProfileView/components/EditProfilePhoneNoField.dart';
import 'package:restaurant_pager/views/EditProfileView/components/EditProfilePicField.dart';
import 'package:restaurant_pager/views/SignUpView/components/CurvedContainer.dart';
import 'package:restaurant_pager/widgets/Button.dart';
import 'package:restaurant_pager/widgets/custom_bottomNavbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final editProfileController = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 223,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurvedContainer(),
                    child: Container(
                      color: const Color.fromRGBO(247, 249, 250, 1),
                      height:161, 
                    ),
                  ),
                  const Positioned(
                    top: 111,
                    left: 0,
                    right: 0, 
                    child: Center(
                      child: EditProfilePicField(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 7.4,),
                    // name field
                    const EditProfileNameField(),
                    const SizedBox(height: 18,),
                    // date field
                    const EditProfileDateField(),
                    const SizedBox(height: 18,),
                    // gender field
                    const EditProfileGenderField(),
                    const SizedBox(height: 18,),
                    // phone field
                    const EditProfilePhoneNoField(),
                    const SizedBox(height: 18,),
                    // email field
                    const EditProfileEmailField(),
                    const SizedBox(height: 32,),
                    Button(onPressed: (){}, text: "Save Changes")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
