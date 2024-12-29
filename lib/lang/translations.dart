import 'package:get/get.dart';
import 'package:test1/lang/ar.dart';
import 'package:test1/lang/en.dart';
class Translation extends Translations{
  @override
  Map<String,Map<String,String>> get keys =>{
    'ar' : ar,
    'en': en,
  };
}