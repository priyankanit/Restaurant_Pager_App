import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/history_controller/history_controller.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/home_controller/home_controller.dart';


class DashboardBinding  extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<DashboardController>(()=>DashboardController());
    Get.lazyPut<HomeController>(()=>HomeController());
    Get.lazyPut<HistoryController>(()=> HistoryController());
  }
}