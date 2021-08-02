import 'package:boilerplate/models/accident/accident.dart';

class AccidentList {
  final List<Accident>? accidents;

  AccidentList({
    this.accidents,
  });

  factory AccidentList.fromJson(List<dynamic> json) {
    List<Accident> accidents = <Accident>[];
    accidents = json.map((post) => Accident.fromJson(post)).toList();

    return AccidentList(
      accidents: accidents,
    );
  }
}
