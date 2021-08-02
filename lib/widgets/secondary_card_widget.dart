import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';

class SecondaryCardWidget extends StatelessWidget {
  final Widget? img;
  final String? title;
  final String? caption;
  final String? heading;
  final String? firstKey;
  final String? secondKey;
  final String? firstValue;
  final String? secondValue;

  const SecondaryCardWidget({
    this.img,
    this.title,
    this.caption,
    this.heading,
    this.firstKey,
    this.secondKey,
    this.firstValue,
    this.secondValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.primaryColor)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              img!,
              Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(title!,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.darkBlueColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(caption!, style: TextStyle(color: AppColors.greyColor)),
              ])
            ]),
            SizedBox(height: 10),
            Text(heading!,
                style: TextStyle(
                    color: AppColors.darkBlueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                firstKey!,
                style: TextStyle(color: AppColors.descriptionColor),
              ),
              Spacer(),
              Text(
                firstValue!,
                style: TextStyle(
                    color: AppColors.darkBlueColor,
                    fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(height: 5),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(secondKey!,
                  style: TextStyle(color: AppColors.descriptionColor)),
              Spacer(),
              Text(
                secondValue!,
                style: TextStyle(
                    color: AppColors.darkBlueColor,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ])),
    );
  }
}
