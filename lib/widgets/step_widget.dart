import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/stores/accident/accident_form_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  final int? number;
  final AccidentFormStore? accidentFormStore;
  const StepWidget({Key? key, this.number, this.accidentFormStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      container(1),
      Expanded(child: Divider(color: AppColors.lightBlueColor, thickness: 2)),
      container(2),
      Expanded(child: Divider(color: AppColors.lightBlueColor, thickness: 2)),
      container(3),
      Expanded(child: Divider(color: AppColors.lightBlueColor, thickness: 2)),
      container(4),
      Expanded(child: Divider(color: AppColors.lightBlueColor, thickness: 2)),
      container(5)
    ]);
  }

  Widget container(int id) {
    return InkWell(
      onTap: () => accidentFormStore!.step = id,
      child: Container(
          padding: EdgeInsets.all(5),
          width: 30,
          decoration: BoxDecoration(
            color: number == id
                ? AppColors.darkBlueColor
                : AppColors.lightBlueColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
              child:
                  Text(id.toString(), style: TextStyle(color: Colors.white)))),
    );
  }
}
