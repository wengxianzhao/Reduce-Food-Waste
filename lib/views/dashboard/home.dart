import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class Home extends StatefulWidget {
  final UserModal user;
  const Home({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.only(left: 20.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Common.foodCategories.length,
              itemBuilder: (BuildContext context, int i) {
                FoodCategory foodCategory = Common.foodCategories[i];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = i;
                    });
                  },
                  child: CategoryBlock(
                    title: foodCategory.title,
                    isActive: selectedCategoryIndex == i,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ApiRequests.getFoodItems(selectedCategoryIndex),
              builder: (context, snapshot) {
                if (!(snapshot.hasData)) return LoadingFoodItemCardList();
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot foodItemDocument =
                        snapshot.data!.docs[index];
                    FoodItemModal foodItem = FoodItemModal.fromJson(
                        foodItemDocument.data() as Map<String, dynamic>);
                    return FoodItem(foodItem: foodItem, user: widget.user);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
