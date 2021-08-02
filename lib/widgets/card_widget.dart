import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatelessWidget {
  final String? img;
  final String? headline;
  final String? caption;
  final String? firstDetail;
  final String? secondDetail;
  const CardWidget({
    this.img,
    this.headline,
    this.caption,
    this.firstDetail,
    this.secondDetail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.primaryColor)),
          child: Column(children: [
            Row(children: [
              SvgPicture.asset(img!),
              SizedBox(width: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(AppLocalizations.of(context)!.translate(headline!),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(AppLocalizations.of(context)!.translate(caption!),
                    style: TextStyle(color: AppColors.greyColor)),
              ])
            ]),
            SizedBox(height: 15),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(String.fromCharCode(0x2022),
                  style: TextStyle(color: AppColors.descriptionColor)),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.translate(firstDetail!),
                  style: TextStyle(color: AppColors.descriptionColor),
                ),
              )
            ]),
            SizedBox(height: 5),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(String.fromCharCode(0x2022),
                  style: TextStyle(color: AppColors.descriptionColor)),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                    AppLocalizations.of(context)!.translate(secondDetail!),
                    style: TextStyle(color: AppColors.descriptionColor)),
              )
            ]),
          ])),
    );
  }
}
