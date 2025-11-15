import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';

class CommonTextfield<T> extends StatelessWidget {
  const CommonTextfield({
    super.key,
    required this.controller,
    required this.changeFunc,
    this.keyboardType = TextInputType.text,
    this.isNumberOnly = false,
    this.icon = const SizedBox.shrink(),
    this.initValue = '',
    this.inputBoxWidth,
    this.inputBoxHeight = AppSize.defaultInputHeight,
  });

  final TextEditingController controller;
  final void Function(String value) changeFunc;
  final TextInputType keyboardType;
  final bool isNumberOnly;
  final Widget icon;
  final String initValue;
  final double? inputBoxWidth;
  final double inputBoxHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inputBoxWidth ?? MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        onChanged: (value) {
          changeFunc(value);
        },
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputBoxBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.accentColor),
          ),
        ),
        inputFormatters:
            isNumberOnly ? [FilteringTextInputFormatter.digitsOnly] : [],
      ),
    );
  }
}
