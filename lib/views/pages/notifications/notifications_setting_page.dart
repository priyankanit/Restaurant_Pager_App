import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/notification_settings/notification_settings_controller.dart';
import 'package:restuarant_pager_app/widgets/custom_bottomNavbar.dart';

class NotificationsSettingPage extends StatelessWidget {
   final NotificationSettingsController controller = Get.put(NotificationSettingsController());
  NotificationsSettingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( 
          backgroundColor: Colors.white,
          elevation: 0,
           title: Padding(
             padding: const EdgeInsets.all(8.0),
             child: SafeArea(
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Center(child: Text('Settings', 
                   style: GoogleFonts.inter(
                    fontWeight:FontWeight.w600, 
                    fontSize:20, 
                    color:const Color(0xff090A0A),
                    ),
                    ),
                    ),
                 ],
               ),
             ),
           ),
            leading: Padding(
              padding: const EdgeInsets.only(left:30.0,),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: InkWell(
                  onTap: (){},
                  splashColor: Colors.grey.shade100,
                  child: Image.asset('assets/images/back_arrow.png', width: 20, height: 20,
                  ),
                ),
              ),
            ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Center(
              child: Text('Options to enable/disable vibrations, sounds, and flashlight alerts for notifications.', 
              style: GoogleFonts.inter(
                fontWeight:FontWeight.w400, 
                fontSize:15, 
                color: const Color(0xff141C24),
                ),
                textAlign: TextAlign.center,
                ),
            ),
              const SizedBox(height: 25,),
              Obx(() => ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff141C24),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  
                    
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/notification_bell.png', height: 10, width: 10,
                    fit: BoxFit.contain,
                    ),
                  ),
                ),
      
                title: Text('Order - Ready alerts',
                style: GoogleFonts.inter(fontWeight:FontWeight.w600, fontSize:17, color:const Color(0xff090A0A),),),
                subtitle: Text('Receive notifications when an order is ready.',
                style: GoogleFonts.inter(
                fontWeight:FontWeight.w400, 
                fontSize:15, 
                color: const Color(0xff141C24),
                ),),
                trailing: CupertinoSwitch(
                  value: controller.orderReadyAlerts.value, 
                onChanged: (value){
                   controller.orderReadyAlerts.value = value;
                },
                activeColor: Colors.green,
                //trackColor: Colors.grey,
                ),
              ),
              ),
              const SizedBox(height: 10,),
              Obx(() => ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff141C24),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/notification_bell.png',
                     height: 10, 
                     width: 10,
                    fit: BoxFit.contain,
                    ),
                  ),
                ),
      
                title: Text('Vibration alerts', style: GoogleFonts.inter(
                  fontWeight:FontWeight.w600, 
                  fontSize:17, 
                  color:const Color(0xff090A0A),
                  ),
                  ),
                subtitle: Text('Enable vibrations for notifications.',
                 style: GoogleFonts.inter(
                fontWeight:FontWeight.w400, 
                fontSize:15, 
                color: const Color(0xff141C24),
                ),),
                trailing: CupertinoSwitch(value: controller.vibrationAlerts.value, 
                onChanged: (value){
                 controller.vibrationAlerts.value = value;
                },
                 activeColor: Colors.green,
                ),
              ),
              ),
              const SizedBox(height: 10.0,),
              Obx(() => ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff141C24),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/notification_bell.png', 
                    height: 10, 
                    width: 10,
                    fit: BoxFit.contain,
                    ),
                  ),
                ),
      
                title: Text('Flashlight alerts', style: GoogleFonts.inter(
                fontWeight:FontWeight.w600, 
                fontSize:17, 
                color:const Color(0xff090A0A),
                ),
                ),
                subtitle: Text('Enable flashlight alerts for notifications.',
                style: GoogleFonts.inter(
                fontWeight:FontWeight.w400, 
                fontSize:15, 
                color: const Color(0xff141C24),
                ),),
                trailing: CupertinoSwitch(
                  value: controller.flashlightAlerts.value, 
                onChanged: (value){
                controller.flashlightAlerts.value = value;
                },
                 activeColor: Colors.green,
                ),
              ),
              ),
      
          ],
          
          ),
          
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0, onItemTapped: (index){}),
        
    );
  }
}