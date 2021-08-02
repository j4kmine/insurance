import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  const AppBarWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                AppLocalizations.of(context)!
                    .translate(text!)!
                    .replaceAll("\n", " "),
                style: TextStyle(color: Colors.white))
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ));
  }

  @override
  Size get preferredSize => Size(0, 55);
}
