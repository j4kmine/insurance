import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecondaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? text;
  const SecondaryAppBarWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppBar(
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.chevron_left,
                      color: AppColors.darkBlueColor, size: 30.0),
                ),
                leadingWidth: 50,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Row(
                  children: <Widget>[
                    Text(
                        AppLocalizations.of(context)!
                            .translate(text!)
                            .replaceAll("\n", " "),
                        style: TextStyle(
                            color: AppColors.darkBlueColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                    SvgPicture.asset('assets/icons/ic_' + text! + '.svg'),
                    SizedBox(width: 20)
                  ],
                ))
          ]),
    );
  }

  @override
  Size get preferredSize => Size(0, 100);
}
