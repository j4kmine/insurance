import 'package:flutter/material.dart';

class MiniProgressIndicatorWidget extends StatelessWidget {
  const MiniProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(25),
          child: CircularProgressIndicator(),
        )));
  }
}
