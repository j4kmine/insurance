import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final int? count;
  final IndexedWidgetBuilder? itemBuilder;
  const ListWidget({
    this.count,
    this.itemBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        ListView.separated(
          physics: new NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: count!,
          separatorBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 2),
            );
          },
          itemBuilder: itemBuilder!,
        ),
      ],
    );
  }
}
