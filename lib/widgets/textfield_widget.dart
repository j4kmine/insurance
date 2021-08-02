import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final bool enabled;
  final TextCapitalization capitalization;

  const TextFieldWidget(
      {Key? key,
      this.icon,
      this.hint,
      this.text = "",
      this.errorText,
      this.isObscure = false,
      this.inputType,
      this.textController,
      this.isIcon = true,
      this.padding = const EdgeInsets.all(0),
      this.hintColor = Colors.grey,
      this.iconColor = Colors.grey,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.autoFocus = false,
      this.inputAction,
      this.enabled = true,
      this.capitalization = TextCapitalization.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            flex: 4, // 60%
            child: TextFormField(
              enabled: false,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: hintColor)),
                  hintText: text,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColors.darkBlueColor),
                  counterText: ''),
            ) /*Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                !text.contains("\n") ? SizedBox(height: 15) : SizedBox(),
                Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: AppColors.darkBlueColor)),
                text.contains("\n")
                    ? SizedBox(height: 14)
                    : SizedBox(height: 16),
                Container(height: 1, color: hintColor),
              ],
            )*/
            ,
          ),
          Expanded(
              flex: 8,
              child: TextFormField(
                textCapitalization: capitalization,
                maxLines: this.inputType == TextInputType.multiline ? null : 1,
                enabled: enabled,
                controller: textController,
                focusNode: focusNode,
                onFieldSubmitted: onFieldSubmitted,
                onChanged: onChanged,
                autofocus: autoFocus,
                textInputAction: inputAction,
                obscureText: this.isObscure,
                maxLength: 25,
                keyboardType: this.inputType,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: hintColor)),
                    hintText: this.hint,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: hintColor),
                    errorText: errorText,
                    errorStyle: TextStyle(height: 0),
                    counterText: ''),
              )),
        ],
      ),
    );
  }
}
