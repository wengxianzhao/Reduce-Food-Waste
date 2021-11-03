import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class Favourite extends StatelessWidget {
  final UserModal user;
  const Favourite({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: ApiRequests.getFavouriteItems(user.id),
        builder: (context, snapshot) {
          if (!(snapshot.hasData))
            return SafeArea(child: LoadingProductCardList());
          if (snapshot.data?.docs.length == 0)
            return NoDataFound(
              title: "No Favourites",
              description:
                  "Press Heart icon on food items to add them in favourite listings. Enjoy Healthy Eating :)",
            );
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot favouriteItemDocument =
                  snapshot.data!.docs[index];
              FoodItemModal favouriteItem = FoodItemModal.fromJson(
                  favouriteItemDocument.data() as Map<String, dynamic>);
              return ProductCard(
                foodItem: favouriteItem,
                user: user,
              );
            },
          );
        },
      ),
    );
  }
}
