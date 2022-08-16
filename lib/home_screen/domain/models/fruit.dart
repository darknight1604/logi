import 'package:equatable/equatable.dart';

class Fruit extends Equatable {
  String? name;
  bool? active;

  Fruit({this.name, this.active});

  Fruit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = name;
    json['active'] = active;
    return json;
  }
  
  @override
  List<Object?> get props => [name, active];
}
