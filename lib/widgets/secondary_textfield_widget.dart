import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';

class SecondaryTextFieldWidget extends StatelessWidget {
  final String text;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final Color hintColor;
  final Color iconColor;
  final Color textColor;
  final FocusNode? focusNode;
  final ValueChanged? onChanged;
  final TextInputAction? inputAction;
  final bool enabled;
  final IconData? suffix;
  final VoidCallback? onTap;
  final TextCapitalization capitalization;

  const SecondaryTextFieldWidget(
      {Key? key,
      this.hint,
      this.text = "",
      this.errorText,
      this.isObscure = false,
      this.inputType,
      this.textController,
      this.hintColor = Colors.grey,
      this.iconColor = Colors.grey,
      this.textColor = Colors.black,
      this.focusNode,
      this.onChanged,
      this.inputAction,
      this.suffix,
      this.onTap,
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
            Text(text,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            Stack(
              children: [
                Padding(
                  padding: suffix != null
                      ? const EdgeInsets.only(right: 24.0)
                      : EdgeInsets.all(0),
                  child: TextFormField(
                    textCapitalization: capitalization,
                    enabled: enabled,
                    controller: textController,
                    onChanged: onChanged,
                    maxLength: inputType == TextInputType.multiline ? 500 : 50,
                    maxLines: inputType == TextInputType.multiline ? null : 1,
                    keyboardType: inputType,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: textColor),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 5),
                        border: InputBorder.none,
                        hintText: this.hint,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: hintColor),
                        counterText: ''),
                  ),
                ),
                suffix != null
                    ? Positioned(
                        right: 0,
                        child: InkWell(
                          onTap: onTap,
                          child: Icon(suffix,
                              color: AppColors.primaryColor, size: 18),
                        ))
                    : Container()
              ],
            ),
            errorText != null
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
