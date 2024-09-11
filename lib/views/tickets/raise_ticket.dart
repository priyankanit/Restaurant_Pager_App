import 'package:flutter/material.dart';
import '../../widgets/textfield.dart';

class SubmitIssuePage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController selectOrderController = TextEditingController();
  final TextEditingController uploadFileController = TextEditingController();

  SubmitIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          'Submit an Issue',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'First Name',
                    hint: 'Enter your first name',
                    controller: firstNameController,
                  ),
                ),
                const SizedBox(width: 10), // Space between the two fields
                Expanded(
                  child: CustomTextField(
                    label: 'Last Name',
                    hint: 'Enter your last name',
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height:24), // Space between rows
            CustomTextField(
              label: 'Email',
              hint: 'Enter your email',
              controller: emailController,
            ),
            const SizedBox(height:24),
            CustomTextField(
                label: 'Select Order (Optional)',
                hint: 'Select order',
                controller: selectOrderController),
            const SizedBox(height:24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Attach files',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                TextField(
                  controller: uploadFileController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Upload your files',
                    suffixIcon: const Icon(Icons.attach_file),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  onTap: () {
                    // Handle file upload
                  },
                ),
              ],
            ),
            const SizedBox(height:24), // Space between fields and description
            CustomTextField(
              label: 'Description',
              hint: 'Describe the issue in detail',
              controller: descriptionController,
              lines: 2,
            ),
            const SizedBox(height:24),
            const Row(
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.orange),
                SizedBox(width: 8), // Space between the icon and the text
                Expanded(
                  child: Text(
                    'A confirmation email with your ticket ID will be sent to the provided email address.',
                    maxLines: 2,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height:30),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Handle form submission
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  textStyle: const TextStyle(fontSize: 16),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Submit Ticket',style: TextStyle(fontWeight: FontWeight.bold,),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
