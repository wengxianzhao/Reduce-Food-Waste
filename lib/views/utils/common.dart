import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reduce_food_waste/modals/food_category.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Common {
  // constants keys for shared preferences
  static const String IS_FIRST_TIME = "IS_FIRST_TIME";

  // firebase constants
  static const String USERS_COLLECTION = "Users";
  static const String FOOD_ITEM_PICTURES = "FoodItemPictures";
  static const String PROFILE_PICTURES = "ProfilePictures";
  static const String FOOD_PICTURES = "FoodPictures";
  static const String FOOD_ITEMS_COLLECTION = "FoodItems";
  static const String ORDERS_COLLECTION = "Orders";
  static const String NEWS_COLLECTION = "News";

  // order constants
  static const String IN_PROGRESS = "In Progress";
  static const String COMPLETED = "Completed";
  static const String CANCELLED = "Cancelled";

  // item constant
  static const String PUBLISHED = "Published";

  static String applicationName = "Reduce Food Waste";

  // assets locations
  static String assetsImages = "assets/images/";
  static String assetsIcons = "assets/icons/";
  static String assetsAnimations = "assets/animations/";

  // food categories
  static List<FoodCategory> foodCategories = [
    FoodCategory(
      id: 0,
      title: "All",
      value: "all",
      imageURL: "",
    ),
    FoodCategory(
      id: 1,
      title: "Fruits",
      value: "fruits",
      imageURL: "",
    ),
    FoodCategory(
      id: 1,
      title: "Vegetables",
      value: "vegetables",
      imageURL: "",
    ),
    FoodCategory(
      id: 2,
      title: "Grains",
      value: "grains",
      imageURL: "",
    ),
    FoodCategory(
      id: 3,
      title: "Protein",
      value: "protein",
      imageURL: "",
    ),
    FoodCategory(
      id: 4,
      title: "Diary",
      value: "diary",
      imageURL: "",
    ),
  ];

  static showOnePrimaryButtonDialog({
    required BuildContext context,
    String? dialogMessage,
    Widget? child,
    bool isDismissible = true,
    String primaryButtonText = "Okay",
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => new AlertDialog(
        title: new Text(Common.applicationName),
        content: child ?? Text(dialogMessage!),
        actions: <Widget>[
          PrimaryButton(
            onPressed: onPressed ?? () => Navigator.pop(context),
            buttonText: primaryButtonText,
            fontSize: 14.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
          ),
        ],
      ),
    );
  }

  // navigation functions
  static void push(BuildContext context, Widget toScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => toScreen));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget toScreen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => toScreen),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showErrorTopSnack(BuildContext context, String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  static void showSuccessTopSnack(BuildContext context, String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        message: message,
      ),
    );
  }

  static Future<String> getCurrentAddress(BuildContext context) async {
    // From coordinates
    String? _address;
    await Geolocator.getCurrentPosition().then((value) async {
      final coordinates = new Coordinates(value.latitude, value.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      _address = addresses.first.addressLine;
    }).onError((error, stackTrace) {
      Common.showErrorTopSnack(context, "$error");
      Future.delayed(Duration(seconds: 3), () => Common.pop(context));
    });
    return _address!;
  }
}
