import 'package:get/get.dart';
import '../core/service/app_configuration_service.dart';
import '../../model/gender.dart';
import '../../model/marital_status.dart';
import '../../model/nationality.dart';
import '../../model/country.dart';
import '../../model/job_experience.dart';
import '../../model/career_level.dart';
import '../../model/industry.dart';
import '../../model/functional_area.dart';
import '../../model/currency.dart';

class AppConfigurationController extends GetxController {
  // البيانات التي سيتم تحميلها من SharedPreferences
  var genders = <Gender>[].obs;
  var maritalStatuses = <MaritalStatus>[].obs;
  var nationalities = <Nationality>[].obs;
  var countries = <Country>[].obs;
  var jobExperiences = <JobExperience>[].obs;
  var careerLevels = <CareerLevel>[].obs;
  var industries = <Industry>[].obs;
  var functionalAreas = <FunctionalArea>[].obs;
  var currencies = <Currency>[].obs;

  bool isLoading = false;
  @override
  void onInit() async{
    isLoading = true;
   await fetchConfiguration();
    isLoading = false;
    update();
    super.onInit();

  }

  Future<void> fetchConfiguration() async {
    // استدعاء خدمة تحميل التكوين وتخزين البيانات
    final service = AppConfigurationService();
    await service.fetchAndStoreConfig();

    // استرجاع البيانات من SharedPreferences وتحديث الحالة
    updateData();
  }

  Future<void> updateData() async {
    final service = AppConfigurationService();
    genders.value = await service.getGenders();
    maritalStatuses.value = await service.getMaritalStatuses();
    nationalities.value = await service.getNationalities();
    countries.value = await service.getCountries();
    jobExperiences.value = await service.getJobExperiences();
    careerLevels.value = await service.getCareerLevels();
    industries.value = await service.getIndustries();
    functionalAreas.value = await service.getFunctionalAreas();
    currencies.value = await service.getCurrencies();
  }
}
