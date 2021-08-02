import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String? title;
  final List<String>? titles;
  final List<String>? values;
  const DetailWidget({
    this.title,
    this.titles,
    this.values,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [
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
          SizedBox(height: 10)
        ]),
      )
    ];
    for (int i = 0; i < titles!.length; i++) {
      if (titles?[i] != null && titles![i] != "") {
        rows.add(_buildRow(
            _buildInfo(titles![i], values![i]),
            i + 1 < titles!.length &&
                    titles?[i + 1] != null &&
                    titles?[i + 1] != ""
                ? _buildInfo(titles![i + 1], values![i + 1])
                : Container()));
        i++;
      }
    }
    return Column(children: rows);
  }

  Widget _buildRow(Widget firstCol, Widget secondCol) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: firstCol,
      ),
      SizedBox(width: 20),
      Expanded(
        flex: 1,
        child: secondCol,
      )
    ]);
  }

  Widget _buildInfo(String header, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header, style: TextStyle(color: AppColors.greyColor)),
        SizedBox(height: 5),
        Text(description != null ? description : '-',
            style: TextStyle(
                color: AppColors.darkBlueColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 20)
      ],
    );
  }
}
