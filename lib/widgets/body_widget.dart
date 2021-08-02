import 'package:boilerplate/widgets/scrollable_widget.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final Widget? firstWidget;
  final Widget? secondWidget;
  final Widget? thirdWidget;
  final double height;
  const BodyWidget(
      {Key? key,
      this.firstWidget,
      this.secondWidget,
      this.thirdWidget,
      this.height = 220})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          firstWidget!,
          thirdWidget != null
              ? ScrollableWidget(
                  height: MediaQuery.of(context).size.height - height,
                  child: secondWidget)
              : ScrollableWidget(
                  height: MediaQuery.of(context).size.height - 135,
                  child: secondWidget),
          thirdWidget != null ? thirdWidget! : Container()
        ],
      ),
    );
  }
}
