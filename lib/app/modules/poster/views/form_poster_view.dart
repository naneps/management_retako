import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/modules/poster/controllers/poster_controller.dart';

class FormPosterView extends GetView<PosterController> {
  const FormPosterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: 'Tambah Poster',
              hasRightIcon: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    RoundedContainer(
                      height: 400,
                      width: Get.width,
                      child: Obx(() {
                        return controller.url.value.path == ''
                            ? const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                              )
                            : Image.file(File(controller.url.value.path));
                      }),
                    ),
                    RoundedContainer(
                      margin: const EdgeInsets.only(top: 10),
                      child: XButton(
                        text: 'Pilih Poster',
                        onPressed: () {
                          // controller.pickImage();
                          controller.pickImage();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedContainer(
                      child: XButton(
                        text: 'Simpan',
                        onPressed: () {
                          // controller.pickVideo();
                          controller.addPoster();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
