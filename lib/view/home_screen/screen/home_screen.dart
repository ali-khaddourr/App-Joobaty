import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/app_configuration.dart';
import 'package:test1/core/const_data/app_colors.dart';
import 'package:test1/core/const_data/app_image.dart';
import 'package:test1/core/const_data/my_size.dart';
import 'package:test1/model/job_experience.dart';
import 'package:test1/view/drower_screen/screen/drower_screen.dart';
import 'package:test1/view/findjobs_screen/controller/find_jobs_controller.dart';
import 'package:test1/view/home_screen/controller/home_controller.dart';
import 'package:test1/view/home_screen/screen/BlogDetailScreen.dart';
import 'package:test1/view/messages_screen/screen/message_screen.dart';
import '../../../model/country.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:html/parser.dart' show parse;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _convertHtmlToText(String html) {
    final document = parse(html);
    return document.body?.text ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    var controllerFind = Get.put(FindJobsController());
    var controllerCon = Get.put(AppConfigurationController());
    var homeController = Get.put(HomeController()); // تأكد من أنه هنا



    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(MySize.md),
          child: Image.asset(AppImage.LogoImage),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Get.to(MessageScreen());
            },
          ),

          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: DrowerScreen(),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(MySize.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'what'.tr,
                    style: TextStyle(
                      fontSize: MySize.fontSizeXlg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MySize.md),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: controller.searchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'hint_search'.tr,
                                      icon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Card(
                                child: Obx(() {
                                  Country? selectedCountry = controller.selectedCountries.isNotEmpty
                                      ? controller.selectedCountries.first
                                      : null;

                                  return DropdownButtonFormField<Country>(
                                    value: selectedCountry,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'hint_country'.tr,
                                      icon: Icon(Icons.location_on),
                                    ),
                                    items: controllerCon.countries.map((country) {
                                      return DropdownMenuItem<Country>(
                                        value: country,
                                        child: Text(country.name ?? 'Unknown'),
                                      );
                                    }).toList(),
                                    onChanged: (Country? newValue) {
                                      controller.toggleCountrySelection(newValue!);
                                    },
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MySize.md),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: MySize.md),
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.saveSearch();
                        controllerFind.fetchData(
                          search: controller.searchController.text,
                          countryIds: controller.selectedCountryIds,
                        );
                        await controller.fetchCities(); // استدعاء fetchCities هنا
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MySize.borderRadius),
                        ),
                      ),
                      child: Text(
                        'find_jobs'.tr,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: MySize.fontSizeLg,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.md),
                  Text(
                    'job_by_cities'.tr,
                    style: TextStyle(
                      fontSize: MySize.fontSizeXlg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MySize.md),
                  Obx(() { // استخدام Obx لتحديث الواجهة تلقائيًا
                    if (controller.cities.isEmpty) {
                      return Center(child: Text('No cities found'));
                    }
                    return SizedBox(
                      height: 250, // ارتفاع محدد لـ Carousel
                      child: CarouselSlider.builder(
                        itemCount: controller.cities.length,
                        itemBuilder: (context, index, realIndex) {
                          final city = controller.cities[index];
                          return GestureDetector(
                            onTap: () {
                              // Trigger the search again
                              controllerFind.fetchData(
                                cityId: [city['city_id']], // تمرير قائمة المعرفات
                              );
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      city['upload_image'] != null && city['upload_image'].isNotEmpty
                                          ? 'https://www.jobaaty.com/city_images/${city['upload_image']}'
                                          : 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    city['city_name'],
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text('${city['num_jobs']} Open Jobs'),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          autoPlay: true,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: MySize.md),
                  Text(
                    'latest_blogs'.tr, // عنوان قسم المدونات
                    style: TextStyle(
                      fontSize: MySize.fontSizeXlg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MySize.md),
                  Obx(() {
                    if (controller.blogs.isEmpty) {
                      return Center(child: Text('No blogs found'));
                    }
                    return SizedBox(
                      height: 400, // ارتفاع أكبر للCarousel
                      child: CarouselSlider.builder(
                        itemCount: controller.blogs.length,
                        itemBuilder: (context, index, realIndex) {
                          final blog = controller.blogs[index];
                          return GestureDetector(
                            onTap: () {
                              // هنا يمكنك إضافة وظيفة للانتقال إلى تفاصيل المدونة
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              elevation: 5, // إضافة ظل للبطاقة
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15), // زوايا دائرية
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15), // الحفاظ على الزوايا الدائرية للصورة
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9, // نسبة العرض إلى الارتفاع
                                      child: Image.network(
                                        'https://www.jobaaty.com/uploads/blogs/${blog['image']}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            blog['heading'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,

                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _convertHtmlToText(blog['content']),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey[600]), // لون رمادي للنص
                                          ),
                                          SizedBox(height: 10),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BlogDetailScreen(blog: blog),
                                                ),
                                              );
                                            },
                                            child: Text('read_more'.tr,style: TextStyle(color: Colors.red[900]),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: heightScreen * 0.49 , // ارتفاع للCarousel
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          // viewportFraction: 0.9, // زيادة نسبة العرض
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5), // مدة عرض كل عنصر
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: MySize.md), // إضافة مسافة في الأسفل
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
