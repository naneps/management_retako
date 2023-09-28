import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/buttons/x_Icon_button.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/poster/bindings/poster_binding.dart';
import 'package:getx_pattern_starter/app/modules/poster/views/form_poster_view.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/poster_controller.dart';

class PosterView extends GetView<PosterController> {
  const PosterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const FormPosterView(),
            binding: PosterBinding(),
          );
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: 'Kelola Poster',
              hasRightIcon: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: controller.getPoster(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return RoundedContainer(
                          color: Colors.transparent,
                          hasBorder: true,
                          borderColor: Colors.brown,
                          borderWidth: 2,
                          child: Stack(
                            children: [
                              RoundedContainer(
                                width: Get.width,
                                height: 300,
                                color: Colors.transparent,
                                child: PhotoView(
                                  tightMode: true,
                                  enablePanAlways: true,
                                  backgroundDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  imageProvider:
                                      Image.network(snapshot.data![index].url!)
                                          .image,
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  child: Row(
                                    children: [
                                      //button edit dan hapus
                                      //button edit dan hapus

                                      XIconButton(
                                        icon: Icons.delete,
                                        size: 25,
                                        color: Colors.red,
                                        onTap: () {
                                          Utils.confirmDialog(
                                            title: 'Hapus Poster',
                                            message:
                                                'Apakah Anda yakin ingin menghapus poster ini?',
                                            onConfirm: () {
                                              controller.deletePoster(
                                                  snapshot.data![index].id!);
                                              Get.back();
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
