import 'dart:core';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class SecondaryDropDownWidget extends StatelessWidget {
  final String text;
  final String? errorText;
  final String value;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final bool enabled;
  final List<String>? options;
  final Map<String, dynamic>? values;

  const SecondaryDropDownWidget(
      {Key? key,
      this.text = "",
      this.errorText,
      this.value = "",
      this.isObscure = false,
      this.inputType,
      this.textController,
      this.isIcon = true,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.autoFocus = false,
      this.inputAction,
      this.enabled = true,
      this.options,
      this.values})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.primaryColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                value: value,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor),
                iconSize: 24,
                style: const TextStyle(color: Colors.black),
                underline: Container(),
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                onChanged: onChanged,
                items: options != null
                    ? options!.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: values != null && values![value] != null
                              ? values![value].toString()
                              : value,
                          child: Text(value == '' || value == null
                              ? AppLocalizations.of(context)!
                                  .translate("select")
                              : AppLocalizations.of(context)!.translate(value)),
                        );
                      }).toList()
                    : []),
            errorText != null && errorText != ''
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(errorText!,
                        style: TextStyle(color: AppColors.dangerColor)),
                  )
                : Container()
          ],
        ));
  }
}
