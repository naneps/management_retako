import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/themes/theme.dart';

// ignore: must_be_immutable
class XButton extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  bool? isDisabled;
  double? width;
  double? height;
  double? size;
  Color? color;
  EdgeInsets? padding;
  FontWeight? fontWeight;
  double? radius;
  double sizeText;
  Color? borderColor;
  bool? hasBorder;
  RadiusType? radiusType;
  Color? textColor;
  Color? disabledColor;
  double? borderWidth;
  bool? hasIcon;
  double? elevation;
  IconData? icon;
  XButton({
    super.key,
    this.onPressed,
    this.text,
    this.isDisabled = false,
    this.hasIcon = false,
    this.disabledColor,
    this.width,
    this.height,
    this.elevation = 1,
    this.size,
    this.hasBorder = false,
    this.sizeText = 16,
    this.borderWidth = 1,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    this.radius = 10,
    this.color,
    this.fontWeight,
    this.borderColor,
    this.textColor,
    this.radiusType = RadiusType.rounded,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      onHover: (value) {
        if (value) {
          Utils.hapticFeedback();
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        fixedSize: Size(size ?? width ?? Get.width, size ?? height ?? 50),
        backgroundColor:
            isDisabled! ? disabledColor : color ?? ThemeApp.primaryColor,
        padding: padding,
        textStyle: TextStyle(
          fontSize: sizeText,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
        maximumSize: Size(size ?? width ?? Get.width, size ?? height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: Utils.handleRequestRadius(
              radius: radius!, radiusType: radiusType!),
          side: hasBorder!
              ? BorderSide(
                  color: borderColor ?? ThemeApp.primaryColor,
                  width: borderWidth!,
                )
              : BorderSide.none,
        ),
        minimumSize: Size(size ?? width ?? Get.width, size ?? height ?? 50),
      ),
      onPressed: isDisabled! ? null : onPressed,
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: hasIcon!,
              child: Icon(
                icon,
                color: textColor,
                size: 20,
              ),
            ),
            Visibility(
              visible: hasIcon!,
              child: const SizedBox(width: 5),
            ),
            Text(
              text ?? "Button",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDisabled! ? ThemeApp.grayTextColor : textColor,
                fontSize: sizeText,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
