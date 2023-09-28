import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/common/x_video_player.dart';
import 'package:getx_pattern_starter/app/modules/video/bindings/video_binding.dart';
import 'package:getx_pattern_starter/app/modules/video/views/form_video_view.dart';

import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(VideoController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              () => const FormVideoView(),
              binding: VideoBinding(),
            );
          },
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              XAppBar(
                title: 'Kelola Video',
                hasRightIcon: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: controller.getVideo(),
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
                            child: ListTile(
                              onTap: () {
                                Get.defaultDialog(
                                  title: snapshot.data![index].title!,
                                  content: RoundedContainer(
                                    width: Get.width,
                                    height: 200,
                                    child: ReusableVideoPlayer(
                                      videoUrl: snapshot.data![index].url!,
                                    ),
                                  ),
                                );
                              },
                              leading: const SizedBox(
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.video_collection,
                                    size: 30,
                                  ),
                                ),
                              ),
                              title: Text(snapshot.data![index].title!),
                              trailing: IconButton(
                                onPressed: () {
                                  Utils.confirmDialog(
                                    title: 'Hapus Video',
                                    message:
                                        'Apakah Anda yakin ingin menghapus video ini?',
                                    onConfirm: () {
                                      controller.deleteVideo(
                                          snapshot.data![index].id!);
                                      Get.back();
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
