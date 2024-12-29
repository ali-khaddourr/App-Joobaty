import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/service/link.dart';
import '../../model/gender.dart';
import '../../model/marital_status.dart';
import '../../model/nationality.dart';
import '../../model/country.dart';
import '../../model/job_experience.dart';
import '../../model/career_level.dart';
import '../../model/industry.dart';
import '../../model/functional_area.dart';
import '../../model/currency.dart';
import '../../model/city.dart';

class AppConfigurationService {
  Future<void> fetchAndStoreConfig() async {
    try {
      final response = await http.get(
        Uri.parse(AppLink.AppConfigration),
         );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final prefs = await SharedPreferences.getInstance();
        // حذف القيم القديمة
        await prefs.remove('genders');
        await prefs.remove('maritalStatuses');
        await prefs.remove('nationalities');
        await prefs.remove('countries');
        await prefs.remove('jobExperiences');
        await prefs.remove('careerLevels');
        await prefs.remove('industries');
        await prefs.remove('functionalAreas');
        await prefs.remove('currencies');
        await prefs.remove('cities');

        // تخزين القيم الجديدة
        await prefs.setString('genders', json.encode((data['genders'] as List).map((item) => Gender.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('maritalStatuses', json.encode((data['maritalStatuses'] as List).map((item) => MaritalStatus.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('nationalities', json.encode((data['nationalities'] as List).map((item) => Nationality.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('countries', json.encode((data['countries'] as List).map((item) => Country.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('jobExperiences', json.encode((data['jobExperiences'] as List).map((item) => JobExperience.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('careerLevels', json.encode((data['careerLevels'] as List).map((item) => CareerLevel.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('industries', json.encode((data['industries'] as List).map((item) => Industry.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('functionalAreas', json.encode((data['functionalAreas'] as List).map((item) => FunctionalArea.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('currencies', json.encode((data['currencies'] as List).map((item) => Currency.fromJson(item)).toList().map((e) => e.toJson()).toList()));
        await prefs.setString('cities', json.encode((data['cities'] as List).map((item) => City.fromJson(item)).toList().map((e) => e.toJson()).toList()));

        print("تم تخزين البيانات بنجاح");
      } else {
        print("فشل في تحميل بيانات التكوين");
      }
    } catch (e) {
      print("حدث خطأ: $e");
    }
  }

  Future<List<Gender>> getGenders() async {
    final prefs = await SharedPreferences.getInstance();
    final gendersString = prefs.getString('genders') ?? '[]';
    final List<dynamic> jsonList = json.decode(gendersString);
    return jsonList.map((jsonItem) => Gender.fromJson(jsonItem)).toList();
  }

  Future<List<MaritalStatus>> getMaritalStatuses() async {
    final prefs = await SharedPreferences.getInstance();
    final statusesString = prefs.getString('maritalStatuses') ?? '[]';
    final List<dynamic> jsonList = json.decode(statusesString);
    return jsonList.map((jsonItem) => MaritalStatus.fromJson(jsonItem)).toList();
  }

  Future<List<Nationality>> getNationalities() async {
    final prefs = await SharedPreferences.getInstance();
    final nationalitiesString = prefs.getString('nationalities') ?? '[]';
    final List<dynamic> jsonList = json.decode(nationalitiesString);
    return jsonList.map((jsonItem) => Nationality.fromJson(jsonItem)).toList();
  }

  Future<List<Country>> getCountries() async {
    final prefs = await SharedPreferences.getInstance();
    final countriesString = prefs.getString('countries') ?? '[]';
    final List<dynamic> jsonList = json.decode(countriesString);
    return jsonList.map((jsonItem) => Country.fromJson(jsonItem)).toList();
  }
  Future<List<City>> getCities() async {
    final prefs = await SharedPreferences.getInstance();
    final citiesString = prefs.getString('cities') ?? '[]';
    final List<dynamic> jsonList = json.decode(citiesString);
    return jsonList.map((jsonItem) => City.fromJson(jsonItem)).toList();
  }
  Future<List<JobExperience>> getJobExperiences() async {
    final prefs = await SharedPreferences.getInstance();
    final jobExperiencesString = prefs.getString('jobExperiences') ?? '[]';
    final List<dynamic> jsonList = json.decode(jobExperiencesString);
    return jsonList.map((jsonItem) => JobExperience.fromJson(jsonItem)).toList();
  }

  Future<List<CareerLevel>> getCareerLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final careerLevelsString = prefs.getString('careerLevels') ?? '[]';
    final List<dynamic> jsonList = json.decode(careerLevelsString);
    return jsonList.map((jsonItem) => CareerLevel.fromJson(jsonItem)).toList();
  }

  Future<List<Industry>> getIndustries() async {
    final prefs = await SharedPreferences.getInstance();
    final industriesString = prefs.getString('industries') ?? '[]';
    final List<dynamic> jsonList = json.decode(industriesString);
    return jsonList.map((jsonItem) => Industry.fromJson(jsonItem)).toList();
  }

  Future<List<FunctionalArea>> getFunctionalAreas() async {
    final prefs = await SharedPreferences.getInstance();
    final functionalAreasString = prefs.getString('functionalAreas') ?? '[]';
    final List<dynamic> jsonList = json.decode(functionalAreasString);
    return jsonList.map((jsonItem) => FunctionalArea.fromJson(jsonItem)).toList();
  }

  Future<List<Currency>> getCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final currenciesString = prefs.getString('currencies') ?? '[]';
    final List<dynamic> jsonList = json.decode(currenciesString);
    return jsonList.map((jsonItem) => Currency.fromJson(jsonItem)).toList();
  }
}
