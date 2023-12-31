import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';
import 'package:getx_pattern_starter/firebase_options.dart';
import 'package:sp_util/sp_util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(
    () => SpUtil.getInstance(),
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Admin RETAKO",
      initialRoute: Routes.HOME,
      onInit: () {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            print('User is currently signed out!');
            Get.offAllNamed(
              Routes.AUTH,
            );
          } else {
            print('User is signed in!');
            Get.offAllNamed(
              Routes.HOME,
            );
          }
        });
      },
      getPages: AppPages.routes,
      theme: ThemeApp.defaultTheme,
    ),
  );
}
