import '../../domian/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"],
      email: map["email"],
      id: map["id"],
    );
  }

  UserModel copywith({String? id, String? email, String? name}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }
}
