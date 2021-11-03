import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class PostedProducts extends StatelessWidget {
  final UserModal user;
  const PostedProducts({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posted Food Items",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ApiRequests.getPostedProducts(user),
              builder: (context, snapshot) {
                if (!(snapshot.hasData))
                  return LoadingInProgressOrderCardList();
                if (snapshot.data?.docs.length == 0)
                  return NoDataFound(
                    title: "No Posted Items Available",
                    description:
                        "Goto Sell food items tab and post products for sale.",
                  );
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot foodItemDocument =
                        snapshot.data!.docs[index];
                    FoodItemModal foodItem = FoodItemModal.fromJson(
                        foodItemDocument.data() as Map<String, dynamic>);
                    return PostedProductCard(
                      foodItem: foodItem,
                      user: user,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
