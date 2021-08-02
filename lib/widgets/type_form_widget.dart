import 'dart:async';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeFormWidget extends StatelessWidget {
  final String? text;
  final String? hint;
  final String? errorText;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final Color? hintColor;
  final ValueChanged? onChanged;
  final ValueChanged? onSubmit;
  final List<String>? suggestions;
  final bool? autoFocus;
  final TextInputAction? inputAction;
  final bool? enabled;
  final TextCapitalization? capitalization;

  const TypeFormWidget(
      {Key? key,
      this.hint,
      this.text = "",
      this.errorText,
      this.inputType,
      this.textController,
      this.hintColor = Colors.grey,
      this.onChanged,
      this.onSubmit,
      this.suggestions,
      this.autoFocus = false,
      this.inputAction,
      this.enabled = true,
      this.capitalization = TextCapitalization.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.primaryColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text!,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            new AutoCompleteTextField<String>(
              textCapitalization: capitalization,
              controller: textController,
              textInputAction: inputAction,
              keyboardType: this.inputType,
              decoration: InputDecoration(
                  enabled: enabled!,
                  isDense: true,
                  contentPadding: EdgeInsets.only(top: 5),
                  border: InputBorder.none,
                  hintText: this.hint,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: hintColor),
                  counterText: ''),
              textChanged: onChanged,
              clearOnSubmit: false,
              itemSubmitted: onSubmit,
              suggestions: suggestions,
              itemBuilder: (context, suggestion) =>
                  new ListTile(title: new Text(suggestion)),
              itemFilter: (suggestion, input) =>
                  suggestion.toLowerCase().startsWith(input.toLowerCase()) ||
                  input == '',
            ),
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
