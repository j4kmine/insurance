import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String? topLeft;
  final String? topRight;
  final String? bottomLeft;
  final String? bottomRight;
  final GestureTapCallback? onTap;
  final bool dropdown;
  final ValueChanged<String>? selected;

  const ListTileWidget(
      {Key? key,
      this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight = '',
      this.onTap,
      this.dropdown = false,
      this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: dropdown
                ? const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10)
                : const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(topLeft!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.darkBlueColor,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(bottomLeft!,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: AppColors.descriptionColor)),
                      ]),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(topRight!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: topRight ==
                                        AppLocalizations.of(context)!
                                            .translate("cancelled")
                                    ? AppColors.dangerColor
                                    : AppColors.successColor)),
                        SizedBox(height: 5),
                        Text(bottomRight!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.darkBlueColor,
                                fontWeight: FontWeight.bold)),
                      ]),
                ),
                dropdown
                    ? PopupMenuButton<String>(
                        onSelected: selected,
                        itemBuilder: (BuildContext context) {
                          return {
                            AppLocalizations.of(context)!.translate("delete")
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                    : Container(),
              ],
            )));
  }
}
