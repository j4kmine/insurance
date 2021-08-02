import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String? buttonHeading;
  final String? buttonText;
  final Color? buttonColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool loading;

  const RoundedButtonWidget(
      {Key? key,
      this.enabled = true,
      this.buttonHeading,
      this.buttonText,
      this.buttonColor,
      this.textColor = Colors.white,
      this.onPressed,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: FlatButton(
        color: buttonColor,
        padding: EdgeInsets.all(10),
        shape: StadiumBorder(),
        disabledColor: buttonColor,
        onPressed: enabled ? onPressed : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonHeading != null && !loading
                ? Column(
                    children: <Widget>[
                      Text(
                        buttonHeading!.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: textColor.withOpacity(0.6),
                            ),
                      ),
                      SizedBox(height: 4)
                    ],
                  )
                : SizedBox(),
            loading
                ? SizedBox(
                    child: CircularProgressIndicator(
                        strokeWidth: 2, backgroundColor: textColor),
                    height: 15,
                    width: 15)
                : Text(
                    buttonText!,
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontWeight: FontWeight.bold, color: textColor),
                  ),
          ],
        ),
      ),
    );
  }
}
