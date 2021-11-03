import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class LoadingFoodItemCardList extends StatelessWidget {
  const LoadingFoodItemCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return LoadingFoodItemCard();
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
    );
  }
}
