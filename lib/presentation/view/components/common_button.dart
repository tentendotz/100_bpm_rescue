import 'package:flutter/material.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';

///
/// 共通ボタンコンポーネント
///
class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.children,
    required this.tapFunc,
    this.btnWidth = AppSize.defaultBtnWidth,
    this.btnHeight = AppSize.defaultBtnHeight,
    this.bgColor = AppColors.primaryColor,
    this.radiusNum = AppSize.defaultRadius,
  });

  final Widget children;
  final VoidCallback tapFunc;
  final double btnWidth;
  final double btnHeight;
  final MaterialColor bgColor;
  final double radiusNum;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusNum),
          ),
        ),
        onPressed: tapFunc,
        child: children,
      ),
    );
  }
}
