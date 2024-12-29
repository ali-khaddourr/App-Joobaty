import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  User user;

  MyProfileModel({
    required this.user,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String name;
  String email;
  dynamic fatherName;
  dynamic dateOfBirth;
  dynamic genderId;
  dynamic maritalStatusId;
  dynamic nationalityId;
  dynamic nationalIdCardNumber;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  String phone;
  dynamic mobileNum;
  dynamic jobExperienceId;
  dynamic careerLevelId;
  dynamic industryId;
  dynamic functionalAreaId;
  dynamic currentSalary;
  dynamic expectedSalary;
  dynamic salaryCurrency;
  dynamic streetAddress;
  int isActive;
  int verified;
  dynamic verificationToken;
  dynamic provider;
  dynamic providerId;
  dynamic image;
  dynamic bioVideo;
  dynamic coverImage;
  dynamic lang;
  DateTime createdAt;
  DateTime updatedAt;
  int isImmediateAvailable;
  int numProfileViews;
  int packageId;
  dynamic packageStartDate;
  dynamic packageEndDate;
  int jobsQuota;
  int availedJobsQuota;
  dynamic search;
  int isSubscribed;
  dynamic videoLink;
  dynamic emailVerifiedAt;
  dynamic token;

  User({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.fatherName,
    required this.dateOfBirth,
    required this.genderId,
    required this.maritalStatusId,
    required this.nationalityId,
    required this.nationalIdCardNumber,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.phone,
    required this.mobileNum,
    required this.jobExperienceId,
    required this.careerLevelId,
    required this.industryId,
    required this.functionalAreaId,
    required this.currentSalary,
    required this.expectedSalary,
    required this.salaryCurrency,
    required this.streetAddress,
    required this.isActive,
    required this.verified,
    required this.verificationToken,
    required this.provider,
    required this.providerId,
    required this.image,
    required this.bioVideo,
    required this.coverImage,
    required this.lang,
    required this.createdAt,
    required this.updatedAt,
    required this.isImmediateAvailable,
    required this.numProfileViews,
    required this.packageId,
    required this.packageStartDate,
    required this.packageEndDate,
    required this.jobsQuota,
    required this.availedJobsQuota,
    required this.search,
    required this.isSubscribed,
    required this.videoLink,
    required this.emailVerifiedAt,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    name: json["name"],
    email: json["email"],
    fatherName: json["father_name"],
    dateOfBirth: json["date_of_birth"],
    genderId: json["gender_id"],
    maritalStatusId: json["marital_status_id"],
    nationalityId: json["nationality_id"],
    nationalIdCardNumber: json["national_id_card_number"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    phone: json["phone"],
    mobileNum: json["mobile_num"],
    jobExperienceId: json["job_experience_id"],
    careerLevelId: json["career_level_id"],
    industryId: json["industry_id"],
    functionalAreaId: json["functional_area_id"],
    currentSalary: json["current_salary"],
    expectedSalary: json["expected_salary"],
    salaryCurrency: json["salary_currency"],
    streetAddress: json["street_address"],
    isActive: json["is_active"],
    verified: json["verified"],
    verificationToken: json["verification_token"],
    provider: json["provider"],
    providerId: json["provider_id"],
    image: json["image"],
    bioVideo: json["bio_video"],
    coverImage: json["cover_image"],
    lang: json["lang"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isImmediateAvailable: json["is_immediate_available"],
    numProfileViews: json["num_profile_views"],
    packageId: json["package_id"],
    packageStartDate: json["package_start_date"],
    packageEndDate: json["package_end_date"],
    jobsQuota: json["jobs_quota"],
    availedJobsQuota: json["availed_jobs_quota"],
    search: json["search"],
    isSubscribed: json["is_subscribed"],
    videoLink: json["video_link"],
    emailVerifiedAt: json["email_verified_at"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "name": name,
    "email": email,
    "father_name": fatherName,
    "date_of_birth": dateOfBirth,
    "gender_id": genderId,
    "marital_status_id": maritalStatusId,
    "nationality_id": nationalityId,
    "national_id_card_number": nationalIdCardNumber,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "phone": phone,
    "mobile_num": mobileNum,
    "job_experience_id": jobExperienceId,
    "career_level_id": careerLevelId,
    "industry_id": industryId,
    "functional_area_id": functionalAreaId,
    "current_salary": currentSalary,
    "expected_salary": expectedSalary,
    "salary_currency": salaryCurrency,
    "street_address": streetAddress,
    "is_active": isActive,
    "verified": verified,
    "verification_token": verificationToken,
    "provider": provider,
    "provider_id": providerId,
    "image": image,
    "bio_video": bioVideo,
    "cover_image": coverImage,
    "lang": lang,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_immediate_available": isImmediateAvailable,
    "num_profile_views": numProfileViews,
    "package_id": packageId,
    "package_start_date": packageStartDate,
    "package_end_date": packageEndDate,
    "jobs_quota": jobsQuota,
    "availed_jobs_quota": availedJobsQuota,
    "search": search,
    "is_subscribed": isSubscribed,
    "video_link": videoLink,
    "email_verified_at": emailVerifiedAt,
    "token": token,
  };
}
