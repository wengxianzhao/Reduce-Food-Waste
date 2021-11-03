import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';

class ApiRequests {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static bool get isLoggedIn =>
      (_firebaseAuth.currentUser == null) ? false : true;

  static getFoodItems(int selectedCategoryIndex) {
    if (selectedCategoryIndex == 0) {
      return _firebaseFirestore
          .collection(Common.FOOD_ITEMS_COLLECTION)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else {
      return _firebaseFirestore
          .collection(Common.FOOD_ITEMS_COLLECTION)
          .where(
            "category",
            isEqualTo: Common.foodCategories[selectedCategoryIndex].value,
          )
          .orderBy("last_activity_at", descending: true)
          .snapshots();
    }
  }

  static Future<List<FoodItemModal>> getAllFoodItems() async {
    List<FoodItemModal> _list = [];
    await _firebaseFirestore
        .collection(Common.FOOD_ITEMS_COLLECTION)
        .orderBy("created_at", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _list.add(FoodItemModal.fromJson(element.data()));
      });
    });
    return _list;
  }

  static getOrders(String status, UserModal orderedBy) {
    return _firebaseFirestore
        .collection(Common.ORDERS_COLLECTION)
        .where("users", arrayContains: orderedBy.id)
        .where("status", isEqualTo: status)
        .orderBy("last_activity_at", descending: true)
        .snapshots();
  }

  static getPostedProducts(UserModal user) {
    return _firebaseFirestore
        .collection(Common.FOOD_ITEMS_COLLECTION)
        .where("food_posted_by", isEqualTo: user.id)
        .orderBy("last_activity_at", descending: true)
        .snapshots();
  }

  static Future<FoodItemModal> getFoodItemDetail(String foodItemID) async {
    try {
      FoodItemModal? _foodItem;
      await _firebaseFirestore
          .collection(Common.FOOD_ITEMS_COLLECTION)
          .doc(foodItemID)
          .get()
          .then((foodItem) {
        _foodItem =
            FoodItemModal.fromJson(foodItem.data() as Map<String, dynamic>);
      });
      return _foodItem!;
    } on Exception catch (e) {
      print(e);
      throw (e);
    }
  }

  static Future<bool> getFoodItemFavourite(String foodItemID) async {
    if (ApiRequests.isLoggedIn) {
      bool isFoodItemLiked = false;
      UserModal user = await ApiRequests.getLoggedInUser();
      _firebaseFirestore
          .collection(Common.USERS_COLLECTION)
          .where("is_favourite_by", arrayContains: user.id)
          .where("food_item_id", isEqualTo: foodItemID)
          .get()
          .then((value) {
        print(value);
      });
      return isFoodItemLiked;
    } else
      return false;
  }

  static Future<UserModal> getLoggedInUser() async {
    UserModal? _user;
    print(_firebaseAuth.currentUser?.uid);
    await _firebaseFirestore
        .collection(Common.USERS_COLLECTION)
        .doc(_firebaseAuth.currentUser?.uid)
        .get()
        .then((user) {
      _user = UserModal.fromJson(user.data() as Map<String, dynamic>);
    });
    return _user!;
  }

  static Future<void> loginUser(
      BuildContext context, String email, String uid) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: uid)
        .then((value) => Common.showSuccessTopSnack(
            context, "Successfully logged in, Enjoy Food :)"))
        .onError((error, stackTrace) {
      throw (error!);
    });
  }

  static Future<void> registerUser(
      BuildContext context, String username, String email, String uid) async {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: uid)
        .then((value) async {
      await storeUserRecord(value.user!.uid, username, email, uid);
    }).onError((error, stackTrace) => throw (error!));
  }

  static Future<void> storeUserRecord(
      String id, String username, String email, String uid) async {
    DocumentReference usersReference =
        _firebaseFirestore.collection(Common.USERS_COLLECTION).doc(id);
    UserModal _user = UserModal(
      id: id,
      username: username,
      emailAddress: email,
      imageUrl: "",
    );
    await usersReference.set(_user.toJson());
  }

  static Future<void> logout() async {
    if (_firebaseAuth.currentUser!.providerData[0].providerId == "google.com") {
      final googleSignIn = GoogleSignIn();
      try {
        await googleSignIn.disconnect();
      } on PlatformException catch (e) {
        await _firebaseAuth.signOut();
      }
    } else
      await _firebaseAuth.signOut();
  }

  static Future<void> sendResetPasswordCode(
      BuildContext context, String email) async {
    _firebaseAuth.sendPasswordResetEmail(email: email).then(
          (value) => Common.showSuccessTopSnack(context,
              "Password reset email sent to your account. please open your mail-service to proceed"),
        );
  }

  static getNews() {
    return _firebaseFirestore
        .collection(Common.NEWS_COLLECTION)
        .orderBy("created_at", descending: false)
        .snapshots();
  }

  static getFavouriteItems(String userID) {
    return _firebaseFirestore
        .collection(Common.FOOD_ITEMS_COLLECTION)
        .where("is_favourite_by", arrayContains: userID)
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  static getFavouriteItemByUser(String userID, String itemID) {
    return _firebaseFirestore
        .collection(Common.FOOD_ITEMS_COLLECTION)
        .where("is_favourite_by", arrayContains: userID)
        .where("id", isEqualTo: itemID)
        .snapshots();
  }

  static Future<void> processFavourite(
    String foodItemID,
    String userID,
    bool isFavourite,
  ) async {
    _firebaseFirestore
        .collection(Common.FOOD_ITEMS_COLLECTION)
        .doc(foodItemID)
        .update({
      "is_favourite_by": isFavourite
          ? FieldValue.arrayRemove([userID])
          : FieldValue.arrayUnion([userID]),
    });
  }

  static Future<void> createOrder(String orderBy, String foodItemUploaderID,
      String foodItemID, int quantity, double price,
      {required BuildContext context}) async {
    DocumentReference orderReference =
        _firebaseFirestore.collection(Common.ORDERS_COLLECTION).doc();
    OrderModal order = OrderModal(
      id: orderReference.id,
      foodItemUploaderID: foodItemUploaderID,
      quantity: quantity,
      price: price,
      rating: 0,
      createdAt: Timestamp.now(),
      lastActivityAt: Timestamp.now(),
      foodItemId: foodItemID,
      orderBy: orderBy,
      users: [
        orderBy,
        foodItemUploaderID,
      ],
      status: Common.IN_PROGRESS,
    );
    await orderReference
        .set(order.toJson())
        .then((value) => Common.showSuccessTopSnack(context,
            "Order placed. You can view your Order in \"In Progress Orders\" from sidebar"))
        .onError(
            (error, stackTrace) => Common.showErrorTopSnack(context, "$error"));
  }

  static Future<void> processOrder(String userID, String foodItemID,
      String foodPostedBy, int quantity, double discountedPrice,
      {required BuildContext context}) async {
    if (userID == foodPostedBy)
      Common.showErrorTopSnack(
        context,
        "You cannot order your own posted product",
      );
    else
      await ApiRequests.createOrder(
        userID,
        foodPostedBy,
        foodItemID,
        quantity,
        discountedPrice,
        context: context,
      );
  }

  static Future<void> postFoodItem(
      String userID,
      String title,
      String category,
      double discountedPrice,
      double originalPrice,
      String description,
      String address,
      double latitude,
      double longitude,
      String imageURL,
      {required BuildContext context}) async {
    DocumentReference foodItemReference =
        _firebaseFirestore.collection(Common.FOOD_ITEMS_COLLECTION).doc();
    LocationModal _location = new LocationModal(
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
    FoodItemModal foodItem = new FoodItemModal(
      title: title,
      category: category,
      createdAt: Timestamp.now(),
      lastActivityAt: Timestamp.now(),
      discountedPrice: discountedPrice,
      foodPostedBy: userID,
      id: foodItemReference.id,
      imageUrl: imageURL,
      originalPrice: originalPrice,
      description: description,
      location: _location,
    );
    await foodItemReference.set(foodItem.toJson());
  }

  static Future<void> updateFoodItem(
      String userID,
      String foodItemID,
      String title,
      String category,
      double discountedPrice,
      double originalPrice,
      String description,
      String address,
      double latitude,
      double longitude,
      String imageURL,
      {required BuildContext context}) async {
    DocumentReference foodItemReference = _firebaseFirestore
        .collection(Common.FOOD_ITEMS_COLLECTION)
        .doc(foodItemID);
    LocationModal _location = new LocationModal(
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
    FoodItemModal foodItem = new FoodItemModal(
      title: title,
      category: category,
      createdAt: Timestamp.now(),
      lastActivityAt: Timestamp.now(),
      discountedPrice: discountedPrice,
      foodPostedBy: userID,
      id: foodItemID,
      imageUrl: imageURL,
      originalPrice: originalPrice,
      description: description,
      location: _location,
    );
    await foodItemReference.update(foodItem.toJson());
  }

  static Future<String> uploadSelectedImage(File _image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(Common.USERS_COLLECTION)
        .child(Common.PROFILE_PICTURES)
        .child(UniqueKey().toString());

    UploadTask uploadTask = ref.putFile(_image);
    String imageURL = "";
    await uploadTask.then((value) async {
      imageURL = await value.ref.getDownloadURL();
    });
    return imageURL;
  }

  static Future<void> completeOrder(OrderModal order, double rating) async {
    await _firebaseFirestore
        .collection(Common.ORDERS_COLLECTION)
        .doc(order.id)
        .update({
      "status": Common.COMPLETED,
      "rating": rating,
      "last_activity_at": Timestamp.now(),
    });
    return;
  }

  static Future<void> cancelOrder(OrderModal order) async {
    await _firebaseFirestore
        .collection(Common.ORDERS_COLLECTION)
        .doc(order.id)
        .update({
      "status": Common.CANCELLED,
      "last_activity_at": Timestamp.now(),
    });
    return;
  }

  static Future<void> deleteProduct(FoodItemModal foodItem,
      {required BuildContext context}) async {
    if (await ApiRequests.canDeleteFoodItem(foodItem)) {
      // deleting main product from FoodItems collection
      await _firebaseFirestore
          .collection(Common.FOOD_ITEMS_COLLECTION)
          .doc(foodItem.id)
          .delete();

      // deleting orders with this product
      await _firebaseFirestore
          .collection(Common.ORDERS_COLLECTION)
          .where("food_item_id", isEqualTo: foodItem.id)
          .where("status", isEqualTo: Common.COMPLETED)
          .get()
          .then((value) {
        value.docs.forEach((order) async {
          OrderModal _order = OrderModal.fromJson(order.data());
          await _firebaseFirestore
              .collection(Common.ORDERS_COLLECTION)
              .doc(_order.id)
              .delete();
        });
      });
    } else
      Common.showErrorTopSnack(
        context,
        "Order is already in progress with this food item, after completing the order you can proceed with it.",
      );
    return;
  }

  static Future<bool> canDeleteFoodItem(FoodItemModal foodItem) async {
    // checking if orders are in progress with current product
    int length = 0;
    _firebaseFirestore
        .collection(Common.ORDERS_COLLECTION)
        .where("food_item_id", isEqualTo: foodItem.id)
        .where("status", isEqualTo: Common.IN_PROGRESS)
        .get()
        .then((value) {
      length = value.docs.length;
    });
    return (length == 0);
  }

  static Future<void> updateUserProfilePicture(
    UserModal user,
    String imageURL,
  ) async {
    DocumentReference userReference =
        _firebaseFirestore.collection(Common.USERS_COLLECTION).doc(user.id);
    await userReference.update({"image_url": imageURL});
    return;
  }

  static Future<bool> googleLogin() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      await _firebaseAuth.signInWithCredential(authCredential);
      if (!await ApiRequests.userRecordExistInFirestore(
          Common.USERS_COLLECTION, _firebaseAuth.currentUser!.uid)) {
        User currentUser = _firebaseAuth.currentUser!;
        UserModal userModal = UserModal(
          id: currentUser.uid,
          username: googleSignInAccount.displayName!,
          emailAddress: googleSignInAccount.email,
          imageUrl: googleSignInAccount.photoUrl,
        );

        await _firebaseFirestore
            .collection(Common.USERS_COLLECTION)
            .doc(currentUser.uid)
            .set(userModal.toJson());
      }
      return true;
    } catch (e) {
      throw (e);
    }
  }

  static userRecordExistInFirestore(String collection, String userID) async {
    try {
      var reference =
          await _firebaseFirestore.collection(collection).doc(userID).get();
      return reference.exists;
    } catch (e) {
      throw (e);
    }
  }
}
