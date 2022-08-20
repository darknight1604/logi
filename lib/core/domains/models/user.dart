import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? nickname;
  final String? id;
  const User({
    this.id,
    this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        nickname: json['nickname'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['nickname'] = nickname;
    json.removeWhere((key, value) => value == null);
    return json;
  }

  @override
  List<Object?> get props => [id];

  bool get idIsValid => id != null && id?.isNotEmpty == true;
}
