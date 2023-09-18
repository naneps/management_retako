import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/routes/app_pages.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final List<Map<String, dynamic>> menus = [
    {
      "icon": MdiIcons.accountGroup,
      "title": "Responden",
      "route": Routes.RESPONDENT,
    },
    {
      "icon": MdiIcons.formatListBulleted,
      "title": "Kelola Kuesioner",
      "route": Routes.QUESTIONARY,
    },
    {
      "icon": MdiIcons.video,
      "title": "Kelola Video",
      "route": Routes.VIDEO,
    },
    {
      "icon": MdiIcons.image,
      "title": "Kelola Poster",
      "route": Routes.POSTER,
    },
    {
      "icon": MdiIcons.book,
      "title": "Kelola Modul",
      "route": Routes.MODULE,
    },
  ];
}
