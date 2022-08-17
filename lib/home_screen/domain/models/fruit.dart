import 'package:equatable/equatable.dart';

class Fruit extends Equatable {
  final String? id;
  final String? name;
  final bool? active;

  const Fruit({
    this.name,
    this.active,
    this.id,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) => Fruit(
        name: json['name'],
        active: json['active'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = name;
    json['active'] = active;
    json['id'] = id;
    return json;
  }

  @override
  List<Object?> get props => [name, active];

  @override
  String toString() => 'id: $id, name: $name, active: $active';
}
