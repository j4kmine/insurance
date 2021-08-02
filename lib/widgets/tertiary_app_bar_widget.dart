import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class TertiaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? text;
  final VoidCallback? onPressed;
  const TertiaryAppBarWidget({Key? key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: SizedBox(),
        title: Center(
            child: Text(AppLocalizations.of(context)!.translate(text!),
                style: TextStyle(color: Colors.white))),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 24.0),
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop()),
        ]);
  }

  @override
  Size get preferredSize => Size(0, 55);
}
