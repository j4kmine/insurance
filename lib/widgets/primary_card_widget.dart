import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryCardWidget extends StatelessWidget {
  final Widget? img;
  final String? title;
  final String? caption;

  const PrimaryCardWidget({
    this.img,
    this.title,
    this.caption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              img!,
              SizedBox(width: 20),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title!,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(
                        caption!,
                        style: TextStyle(color: AppColors.greyColor),
                      )
                    ]),
              )
            ]));
  }
}
