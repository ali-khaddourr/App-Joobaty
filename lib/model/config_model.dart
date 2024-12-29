// To parse this JSON data, do
//
//     final configurationModel = configurationModelFromJson(jsonString);

import 'dart:convert';

ConfigurationModel configurationModelFromJson(String str) => ConfigurationModel.fromJson(json.decode(str));

String configurationModelToJson(ConfigurationModel data) => json.encode(data.toJson());

class ConfigurationModel {
  List<CareerLevel> genders;
  List<CareerLevel> maritalStatuses;
  List<CareerLevel> nationalities;
  List<CareerLevel> countries;
  List<CareerLevel> jobExperiences;
  List<CareerLevel> careerLevels;
  List<CareerLevel> industries;
  List<CareerLevel> functionalAreas;
  List<CareerLevel> currencies;

  ConfigurationModel({
    required this.genders,
    required this.maritalStatuses,
    required this.nationalities,
    required this.countries,
    required this.jobExperiences,
    required this.careerLevels,
    required this.industries,
    required this.functionalAreas,
    required this.currencies,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) => ConfigurationModel(
    genders: List<CareerLevel>.from(json["genders"].map((x) => CareerLevel.fromJson(x))),
    maritalStatuses: List<CareerLevel>.from(json["maritalStatuses"].map((x) => CareerLevel.fromJson(x))),
    nationalities: List<CareerLevel>.from(json["nationalities"].map((x) => CareerLevel.fromJson(x))),
    countries: List<CareerLevel>.from(json["countries"].map((x) => CareerLevel.fromJson(x))),
    jobExperiences: List<CareerLevel>.from(json["jobExperiences"].map((x) => CareerLevel.fromJson(x))),
    careerLevels: List<CareerLevel>.from(json["careerLevels"].map((x) => CareerLevel.fromJson(x))),
    industries: List<CareerLevel>.from(json["industries"].map((x) => CareerLevel.fromJson(x))),
    functionalAreas: List<CareerLevel>.from(json["functionalAreas"].map((x) => CareerLevel.fromJson(x))),
    currencies: List<CareerLevel>.from(json["currencies"].map((x) => CareerLevel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genders": List<dynamic>.from(genders.map((x) => x.toJson())),
    "maritalStatuses": List<dynamic>.from(maritalStatuses.map((x) => x.toJson())),
    "nationalities": List<dynamic>.from(nationalities.map((x) => x.toJson())),
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    "jobExperiences": List<dynamic>.from(jobExperiences.map((x) => x.toJson())),
    "careerLevels": List<dynamic>.from(careerLevels.map((x) => x.toJson())),
    "industries": List<dynamic>.from(industries.map((x) => x.toJson())),
    "functionalAreas": List<dynamic>.from(functionalAreas.map((x) => x.toJson())),
    "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
  };
}

class CareerLevel {
  int id;
  String name;

  CareerLevel({
    required this.id,
    required this.name,
  });

  factory CareerLevel.fromJson(Map<String, dynamic> json) => CareerLevel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
