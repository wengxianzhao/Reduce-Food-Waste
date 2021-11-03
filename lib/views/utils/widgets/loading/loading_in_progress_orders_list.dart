import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class LoadingInProgressOrderCardList extends StatelessWidget {
  const LoadingInProgressOrderCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return LoadingInProgressOrderCard();
      },
    );
  }
}
