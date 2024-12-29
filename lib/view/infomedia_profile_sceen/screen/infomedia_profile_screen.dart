import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/view/infomedia_profile_sceen/controller/infomedia_profile_controller.dart';

class InfomediaProfileScreen extends StatelessWidget {
  const InfomediaProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfomediaProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Upload'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Image Section
              Obx(() {
                return controller.profileImage.value != null && !controller.isUploading.value
                    ? Column(
                  children: [
                    Image.file(controller.profileImage.value!),
                    const SizedBox(height: 16),
                  ],
                )
                    : controller.isUploading.value
                    ? const CircularProgressIndicator()
                    : Column(
                  children: [
                    const Icon(Icons.image, size: 100, color: Colors.grey),
                    const Text('No Profile Image Selected'),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: controller.pickProfileImage,
                child: const Text('Upload Profile Image'),
              ),
              const SizedBox(height: 16),

              // Cover Image Section
              Obx(() {
                return controller.coverImage.value != null && !controller.isUploading.value
                    ? Column(
                  children: [
                    Image.file(controller.coverImage.value!),
                    const SizedBox(height: 16),
                  ],
                )
                    : controller.isUploading.value
                    ? const CircularProgressIndicator()
                    : Column(
                  children: [
                    const Icon(Icons.image, size: 100, color: Colors.grey),
                    const Text('No Cover Image Selected'),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              ElevatedButton(
                onPressed: controller.pickCoverImage,
                child: const Text('Upload Cover Image'),
              ),
              const SizedBox(height: 16),

              // Video Upload Section
              Obx(() {
                return controller.videoFile.value != null && !controller.isUploading.value
                    ? Column(
                  children: [
                    Text('Video Selected: ${controller.videoFile.value!.path}'),
                    const SizedBox(height: 16),
                  ],
                )
                    : controller.isUploading.value
                    ? const CircularProgressIndicator()
                    : const Text('No Video Selected');
              }),
              ElevatedButton(
                onPressed: controller.pickVideo,
                child: const Text('Upload Video'),
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: controller.updateProfileMedia,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
