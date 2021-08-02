import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final Widget? child;
  final double? height;
  const ScrollableWidget({
    this.child,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              constraints: BoxConstraints(minHeight: height!), child: child)),
    );
  }
}
