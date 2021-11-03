import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class FavouriteIcon extends StatelessWidget {
  final String itemID;
  final String userID;
  final bool isSelected;
  const FavouriteIcon({
    Key? key,
    required this.itemID,
    required this.userID,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ApiRequests.isLoggedIn
          ? ApiRequests.processFavourite(itemID, userID, isSelected)
          : Common.push(context, Login()),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.appGreyColor.withOpacity(0.3),
              offset: Offset(1, 2),
              spreadRadius: 5.0,
              blurRadius: 12.0,
            ),
          ],
        ),
        child: Icon(
          isSelected ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
