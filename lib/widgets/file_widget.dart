import 'dart:io';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/primary_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileWidget extends StatelessWidget {
  final String? title;
  final List<String>? files;
  final VoidCallback? onPressed;
  final VoidCallback? onCamera;
  final ValueChanged<int>? onRemoved;

  const FileWidget(
      {Key? key,
      this.title,
      this.files,
      this.onPressed,
      this.onCamera,
      this.onRemoved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title!,
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        files!.length > 0
            ? Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                    // childAspectRatio: itemWidth / itemHeight,
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    children: List.generate(files!.length, (index) {
                      return Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          width: 100,
                          child: Stack(
                            children: [
                              Center(
                                child: Image.file(File(files![index])),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    onRemoved!(index);
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: new BoxDecoration(
                                      color: AppColors.dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: new Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    })),
              )
            : Container(),
        SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: PrimaryButtonWidget(
                img: Icon(Icons.attach_file,
                    color: AppColors.secondaryColor, size: 18),
                onPressed: onPressed,
                textColor: AppColors.secondaryColor,
                borderColor: AppColors.secondaryColor,
                buttonText:
                    AppLocalizations.of(context)!.translate("upload_files"),
                buttonColor: Colors.transparent),
          ),
          SizedBox(width: 10),
          Expanded(
              child: PrimaryButtonWidget(
                  img: Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: 18),
                  onPressed: onCamera,
                  buttonText: AppLocalizations.of(context)!.translate("take"
                      "_photos"),
                  buttonColor: AppColors.secondaryColor))
        ])
      ],
    );
  }
}
