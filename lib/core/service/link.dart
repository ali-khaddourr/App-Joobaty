import 'package:test1/core/const_data/const_data.dart';

class AppLink{
  ///Remote Address
  static String appRoot = "https://www.jobaaty.com";
  //storage images
  static String imageWithRoot = "$appRoot/storage";
  static String imageWithoutRoot = "$appRoot";

  //Api
  static String serverApiRoot="$appRoot/api";


  static String AppConfigration = "$serverApiRoot/user/app-configuration";
  static String login = "$serverApiRoot/login";
  static String signUp = "$serverApiRoot/register";
  static String jobSearch = "$serverApiRoot/jobs/search";
  static String myProfile = "$serverApiRoot/user/my-profile";
  static String addFavorite = "$serverApiRoot/jobs/favourite";
  static String myFavorite = "$serverApiRoot/user/my-favourites";
  static String deleteFavorite = "$serverApiRoot/jobs/favourite";
  static String detaileJobs = "$serverApiRoot/jobs";
  static String applyNow = "$serverApiRoot/jobs/apply";
  static String submitapplyNow = "$serverApiRoot/jobs/apply/submit";

  static String updateProfile = "$serverApiRoot/user/update-profile";
  static String myapplication = "$serverApiRoot/user/my-applications";
  static String updateProfileMedia = "$serverApiRoot/user/update-profile-media";
  static String fetchCv = "$serverApiRoot/user/resume";
  static String deleteCv = "$serverApiRoot/profile-cv/delete";
  static String addcv = "$serverApiRoot/profile-cv";
  static String updatesummry = "$serverApiRoot/update-summary";
  static String jobcities = "$serverApiRoot/jobs/cities";
  static String blogs = "$serverApiRoot/blogs";
  static String MyProfile = "$serverApiRoot/user/my-profile";
  static String getJobStatus = "$serverApiRoot/job/status";
  static String companies = "$serverApiRoot/company/data";
  static String companiesDetails = "$serverApiRoot/companies";
  static String deleteuser = "$serverApiRoot/user/account/delete";




  ///Local Address
  static String req = "127.0.0.1";


  Map<String,String>getHeader(){

    Map<String,String>mainHeader ={
      'Content-Type':'Application/json',
      'Accept':'application/json',
      'X-Requested-With':'XMLHttpRequest',
    };
    return mainHeader;
  }

  Map<String,String>getHeaderToken(){

    Map<String,String>mainHeader ={
      // 'Content-Type':'Application/json',
      'Accept':'application/json',
      // 'X-Requested-With':'XMLHttpRequest',
      'Authorization':'Bearer${ConstData.token}'
    };
    return mainHeader;
  }
}