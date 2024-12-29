import 'package:get/get.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/core/class/curd.dart';
import 'package:test1/core/service/app_configuration_service.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:test1/view/home_screen/controller/home_controller.dart';

//initial controllers
class initialBindings extends Bindings {
  @override
  void dependencies() {

    Get.put(Crud());
    Get.put(AppConfigurationService());
    Get.put(AppConfigurationController());
    Get.put(FindJobsController());
    Get.put(HomeController());

    // Get.put(HomeController(),permanent: true);
  }
}
