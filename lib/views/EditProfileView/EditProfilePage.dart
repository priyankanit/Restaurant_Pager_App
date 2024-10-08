import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/EditProfileController/EditProfileController.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/CurvedContainer.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfileDateField.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfileEmailField.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfileGenderField.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfileNameField.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfilePhoneNoField.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfilePicField.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final editProfileController = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormState>();
  bool clicked = false;

  void _submitForm(){
    if(_formKey.currentState!.validate()) return;
    setState((){
      clicked = true;
    });
    editProfileController.submit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 46.0),
              child: Form(
                key: _formKey,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 7.4,),
                    // name field
                    EditProfileNameField(),
                    SizedBox(height: 18,),
                    // date field
                    EditProfileDateField(),
                    SizedBox(height: 18,),
                    // gender field
                    EditProfileGenderField(),
                    SizedBox(height: 18,),
                    // phone field
                    EditProfilePhoneNoField(),
                    SizedBox(height: 18,),
                    // email field
                    EditProfileEmailField(),
                    SizedBox(height: 32,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Button(
                onPressed: _submitForm,
                text: "Save Changes",
                disable: clicked,
              ),
            )
          ],
        ),
      ),
    );
  }
}
