import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/input/x_field.dart';
import 'package:getx_pattern_starter/app/common/shape/rounded_container.dart';
import 'package:getx_pattern_starter/app/common/ui/x_appbar.dart';
import 'package:getx_pattern_starter/app/modules/module/controllers/module_controller.dart';
import 'package:getx_pattern_starter/app/modules/module/views/pdf_view.dart';

class FormModuleView extends GetView<ModuleController> {
  const FormModuleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: 'Tambah Modul',
              hasRightIcon: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    RoundedContainer(
                      height: 400,
                      child: Obx(
                        () => controller.url.value.path == ''
                            ? const Center(
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  size: 50,
                                ),
                              )
                            : PDFScreen(
                                hasAppBar: false,
                                path: controller.url.value.path,
                              ),
                      ),
                    ),
                    RoundedContainer(
                      margin: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.pickPdf();
                        },
                        child: const Text('Pilih Modul'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Judul Modul',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        XTextField(
                          hintText: 'Masukkan judul modul',
                          onChanged: (value) {
                            controller.title.value = value;
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedContainer(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addModule();
                        },
                        child: const Text('Simpan'),
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
