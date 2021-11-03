import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FoodItemModal foodItemModalFromJson(String str) =>
    FoodItemModal.fromJson(json.decode(str));

String foodItemModalToJson(FoodItemModal data) => json.encode(data.toJson());

class FoodItemModal {
  FoodItemModal({
    required this.title,
    required this.category,
    required this.createdAt,
    required this.lastActivityAt,
    required this.discountedPrice,
    required this.foodPostedBy,
    required this.id,
    required this.imageUrl,
    required this.originalPrice,
    required this.description,
    required this.location,
  });

  String id;
  String foodPostedBy;
  String title;
  String category;
  double originalPrice;
  double discountedPrice;
  String imageUrl;
  String description;
  Timestamp createdAt;
  Timestamp lastActivityAt;
  LocationModal location;

  factory FoodItemModal.fromJson(Map<String, dynamic> json) => FoodItemModal(
        title: json["title"],
        category: json["category"],
        createdAt: json["created_at"],
        lastActivityAt: json["last_activity_at"],
        discountedPrice: json["discounted_price"],
        foodPostedBy: json["food_posted_by"],
        id: json["id"],
        imageUrl: json["image_url"],
        originalPrice: json["original_price"],
        description: json["description"],
        location: LocationModal.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "created_at": createdAt,
        "last_activity_at": lastActivityAt,
        "discounted_price": discountedPrice,
        "food_posted_by": foodPostedBy,
        "id": id,
        "image_url": imageUrl,
        "original_price": originalPrice,
        "description": description,
        "location": location.toJson(),
      };
}

class LocationModal {
  LocationModal({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  String address;
  double latitude;
  double longitude;

  factory LocationModal.fromJson(Map<String, dynamic> json) => LocationModal(
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
