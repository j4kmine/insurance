import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SwitchWidget extends StatelessWidget {
  final String? title;
  final ValueChanged<bool>? onToggle;
  final bool? value;
  final bool border;
  const SwitchWidget(
      {Key? key, this.title, this.onToggle, this.value, this.border = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return border
        ? Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.primaryColor)),
            child: row(context),
          )
        : row(context);
  }

  Widget row(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Text(AppLocalizations.of(context)!.translate(title!),
                style: TextStyle(color: AppColors.darkBlueColor))),
        SizedBox(width: 5),
        FlutterSwitch(
          height: 25,
          width: 50,
          activeColor: AppColors.primaryColor,
          value: value,
          onToggle: onToggle,
        ),
      ],
    );
  }
}
