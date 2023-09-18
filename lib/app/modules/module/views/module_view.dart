import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/modules/module/bindings/module_binding.dart';
import 'package:getx_pattern_starter/app/modules/module/views/form_module_view.dart';
import 'package:getx_pattern_starter/app/modules/module/views/pdf_view.dart';

import '../controllers/module_controller.dart';

class ModuleView extends GetView<ModuleController> {
  const ModuleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const FormModuleView(),
            binding: ModuleBinding(),
          );
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: 'Kelola Modul',
              hasRightIcon: true,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: controller.getModule(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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
                                Get.to(
                                  () => PDFScreen(
                                    path: snapshot.data![index].url!,
                                    title: snapshot.data![index].title!,
                                  ),
                                );
                              },
                              leading: const Icon(Icons.picture_as_pdf),
                              title: Text(snapshot.data![index].title!),
                              trailing: IconButton(
                                onPressed: () {
                                  Utils.confirmDialog(
                                    title: 'Hapus Modul',
                                    message:
                                        'Apakah anda yakin ingin menghapus modul ini?',
                                    onConfirm: () {
                                      controller.deleteModule(
                                          snapshot.data![index].id!);
                                      Get.back();
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              )),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
