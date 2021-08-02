import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesWidget extends StatelessWidget {
  final String? title;
  final List<String>? titles;
  final List<String>? values;
  const FilesWidget({
    this.title,
    this.titles,
    this.values,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < titles!.length; i++) {
      rows.add(_buildInfo(titles![i], values![i]));
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(),
          title != ''
              ? Text(title!,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold))
              : Container(),
          SizedBox(height: 10),
          Wrap(children: rows)
        ]),
      ),
    ]);
  }

  Widget _buildInfo(String header, String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: InkWell(
        onTap: () {
          description != null ? launch(description) : null;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/ic_pdf.svg'),
            SizedBox(height: 5),
            Text(
                header[0].toUpperCase() +
                    header.substring(1).replaceAll("_", " "),
                style: TextStyle(color: AppColors.greyColor)),
          ],
        ),
      ),
    );
  }
}
