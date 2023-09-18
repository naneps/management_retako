import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/module/bindings/module_binding.dart';
import '../modules/module/views/module_view.dart';
import '../modules/poster/bindings/poster_binding.dart';
import '../modules/poster/views/poster_view.dart';
import '../modules/questionare/bindings/questionare_binding.dart';
import '../modules/questionare/views/questionare_view.dart';
import '../modules/respondent/bindings/respondent_binding.dart';
import '../modules/respondent/views/respondent_view.dart';
import '../modules/video/bindings/video_binding.dart';
import '../modules/video/views/video_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.CORE,
      page: () => const CoreView(),
      binding: CoreBinding(),
      children: [
        GetPage(
          name: _Paths.CORE,
          page: () => const CoreView(),
          binding: CoreBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.RESPONDENT,
      page: () => const RespondentView(),
      binding: RespondentBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.POSTER,
      page: () => const PosterView(),
      binding: PosterBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => const VideoView(),
      binding: VideoBinding(),
    ),
    GetPage(
      name: _Paths.MODULE,
      page: () => const ModuleView(),
      binding: ModuleBinding(),
    ),
    GetPage(
      name: _Paths.QUESTIONARY,
      page: () => const QuestionaryView(),
      binding: QuestionaryBinding(),
    ),
  ];
}
