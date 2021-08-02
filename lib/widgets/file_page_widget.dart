import 'dart:io';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/primary_button_widget.dart';
import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FilePageWidget extends StatelessWidget {
  final String? title;
  final List<String>? files;
  final VoidCallback? onPressed;
  final VoidCallback? onCamera;
  final ValueChanged<int>? onRemoved;

  const FilePageWidget(
      {Key? key,
      this.title,
      this.files,
      this.onPressed,
      this.onCamera,
      this.onRemoved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ScrollableWidget(
            height: MediaQuery.of(context).size.height - 220,
            child: files!.length > 0
                ? Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                        // childAspectRatio: itemWidth / itemHeight,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: List.generate(files!.length, (index) {
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
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
                : Container()));
  }
}
