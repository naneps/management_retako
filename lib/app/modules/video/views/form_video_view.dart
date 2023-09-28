import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/common/x_video_player.dart';
import 'package:getx_pattern_starter/app/modules/video/controllers/video_controller.dart';

class FormVideoView extends GetView<VideoController> {
  const FormVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: 'Tambah Video',
              hasRightIcon: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    RoundedContainer(
                      width: Get.width,
                      height: 200,
                      child: Obx(() {
                        return controller.url.value.path == ''
                            ? const Center(
                                child: Icon(
                                  Icons.video_collection,
                                  size: 50,
                                ),
                              )
                            : ReusableVideoPlayer(
                                videoUrl: controller.url.value.path,
                              );
                      }),
                    ),
                    const SizedBox(height: 5),
                    XButton(
                      text: 'Upload Video',
                      onPressed: () {
                        controller.pickVideo();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Judul Video',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        XTextField(
                          hintText: 'Masukkan Judul Video',
                          onChanged: (value) {
                            controller.title.value = value;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            RoundedContainer(
                margin: const EdgeInsets.all(10),
                child: Obx(
                  () {
                    return controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : XButton(
                            text: 'Simpan',
                            onPressed: () {
                              controller.addVideo();
                            },
                          );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
