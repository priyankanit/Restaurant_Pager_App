import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import '../../../controllers/QrCodeController/qr_code_controller.dart';
import 'package:flutter/services.dart';

class ScannerScreen extends StatelessWidget {
  final QRCodeController qrCodeController = Get.put(QRCodeController());

  ScannerScreen() {
    qrCodeController.fetchCurrentUserDetails();
  }

  Future<void> _saveQrCodeToGallery(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100);
      print(result); // Optional: to see the result of the save operation
      Get.snackbar("Success", "QR code saved to gallery!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save QR code: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _qrKey = GlobalKey();

    return Scaffold(
      backgroundColor: Color(0xfff7f9fa),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f9fa),
        leading: const Icon(Icons.arrow_back),
        centerTitle: true,
        title: const Text(
          "Scan the QR Code",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              _saveQrCodeToGallery(_qrKey);
            },
          ),
        ],
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Obx(() {
            if (qrCodeController.qrCodeLink.value.isEmpty) {
              return CircularProgressIndicator(); // Show a loading indicator
            } else {
              return RepaintBoundary(
                key: _qrKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      qrCodeController.userName.value.isNotEmpty
                          ? qrCodeController.userName.value
                          : "User Name",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Image.network(
                      qrCodeController.qrCodeLink.value,
                      fit: BoxFit.contain,
                      color: Colors.black, // Change the color of the QR code'
                    ),
                    SizedBox(height: 20),
                    Text(
                      "ID: ${qrCodeController.userId.value}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality to share the QR code or perform any action
                      },
                      child: Text("Share this QR Code"),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
