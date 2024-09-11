import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification/notification_model.dart';

class NotificationSettingsController extends GetxController {
  var vibrationEnabled = true.obs;
  var soundEnabled = true.obs;
  var flashLightEnabled = false.obs;
   final List<NotificationModel> notificationsList = [];

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    vibrationEnabled.value = prefs.getBool('vibrationEnabled') ?? true;
    soundEnabled.value = prefs.getBool('soundEnabled') ?? true;
    flashLightEnabled.value = prefs.getBool('flashLightEnabled') ?? false;
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('vibrationEnabled', vibrationEnabled.value);
    prefs.setBool('soundEnabled', soundEnabled.value);
    prefs.setBool('flashLightEnabled', flashLightEnabled.value);
  }

  void toggleVibration(bool value) {
    vibrationEnabled.value = value;
    _saveSettings();
  }

  void toggleSound(bool value) {
    soundEnabled.value = value;
    _saveSettings();
  }

  void toggleFlashLight(bool value) {
    flashLightEnabled.value = value;
    _saveSettings();
  }
}
