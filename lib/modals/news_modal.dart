import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NewsModal newsModalFromJson(String str) => NewsModal.fromJson(json.decode(str));

String newsModalToJson(NewsModal data) => json.encode(data.toJson());

class NewsModal {
  NewsModal({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    this.redirectUrl,
  });

  String id;
  String title;
  String description;
  String imageUrl;
  Timestamp createdAt;
  String? redirectUrl;

  factory NewsModal.fromJson(Map<String, dynamic> json) => NewsModal(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"],
        redirectUrl: json["redirect_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image_url": imageUrl,
        "created_at": createdAt,
        "redirect_url": redirectUrl,
      };
}
