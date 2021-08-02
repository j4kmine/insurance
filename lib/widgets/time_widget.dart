import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeWidget extends StatelessWidget {
  final String? text;
  final String? hint;
  final String? errorText;
  final bool? isIcon;
  final TextEditingController? textController;
  final Color hintColor;
  final Color iconColor;
  final ValueChanged? onChanged;
  final TextInputAction? inputAction;
  final TimeOfDay? selectedTime;

  const TimeWidget(
      {Key? key,
      this.hint,
      this.text = "",
      this.errorText,
      this.textController,
      this.isIcon = true,
      this.hintColor = Colors.grey,
      this.iconColor = Colors.grey,
      this.onChanged,
      this.inputAction,
      this.selectedTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        /*
        final picked =
            await showTimePicker(context: context, initialTime: selectedDate);
        */
        final TimeOfDay? picked =
            await showTimePicker(context: context, initialTime: selectedTime!);
        if (picked != null && picked != selectedTime) {
          String hr = picked.hour < 10
              ? "0" + picked.hour.toString()
              : picked.hour.toString();
          String min = picked.minute < 10
              ? "0" + picked.minute.toString()
              : picked.minute.toString();
          textController!.text = hr + ":" + min;
          onChanged!(textController!.text);
        }
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
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
              Stack(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: textController,
                    textInputAction: inputAction,
                    maxLength: 50,
                    style: Theme.of(context).textTheme.bodyText1,
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
                  Positioned(
                      right: 0,
                      child: Icon(Icons.timer,
                          color: AppColors.primaryColor, size: 18)),
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
          )),
    );
  }
}
