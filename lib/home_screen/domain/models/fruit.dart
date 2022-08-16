import 'package:equatable/equatable.dart';

class Fruit extends Equatable {
  final String? name;
  final bool? active;

  const Fruit({this.name, this.active});

  factory Fruit.fromJson(Map<String, dynamic> json) => Fruit(
        name: json['name'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = name;
    json['active'] = active;
    return json;
  }

  @override
  List<Object?> get props => [name, active];
}
