import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class LoadingNewsCardList extends StatelessWidget {
  const LoadingNewsCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return LoadingNewsCard();
      },
    );
  }
}
