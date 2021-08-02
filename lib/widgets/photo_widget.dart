import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final String? title;
  final String? count;

  const PhotoWidget({Key? key, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.primaryColor)),
        child: Row(children: [
          Text(title!),
          Spacer(),
          Text("[${count}]"),
          SizedBox(width: 20),
          Icon(Icons.arrow_right_alt)
        ]));
  }
}
