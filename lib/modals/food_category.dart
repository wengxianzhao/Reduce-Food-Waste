import 'dart:convert';

FoodCategory foodCategoryFromJson(String str) =>
    FoodCategory.fromJson(json.decode(str));

String foodCategoryToJson(FoodCategory data) => json.encode(data.toJson());

class FoodCategory {
  FoodCategory({
    required this.id,
    required this.title,
    required this.value,
    required this.imageURL,
  });

  int id;
  String title;
  String value;
  String imageURL;

  factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        imageURL: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "value": value,
        "image_url": imageURL,
      };
}
