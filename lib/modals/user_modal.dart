import 'dart:convert';

UserModal userModalFromJson(String str) => UserModal.fromJson(json.decode(str));

String userModalToJson(UserModal data) => json.encode(data.toJson());

class UserModal {
  UserModal({
    required this.id,
    required this.username,
    required this.emailAddress,
    this.imageUrl,
  });

  String id;
  String username;
  String emailAddress;
  String? imageUrl;

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        id: json["id"],
        username: json["username"],
        emailAddress: json["email_address"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email_address": emailAddress,
        "image_url": imageUrl,
      };
}
