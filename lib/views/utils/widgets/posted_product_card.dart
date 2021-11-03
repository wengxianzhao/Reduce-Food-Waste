import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

import '../common.dart';

class PostedProductCard extends StatelessWidget {
  final FoodItemModal foodItem;
  final UserModal user;
  const PostedProductCard({
    Key? key,
    required this.foodItem,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Common.push(
        context,
        EditProduct(
          user: user,
          foodItem: foodItem,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 180.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appGreyColor.withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 8,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(foodItem.imageUrl),
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(
                      AppColors.appBlackColor.withOpacity(0.8),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appBlueColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 5.0,
                  ),
                  child: Text(
                    Common.PUBLISHED,
                    style: TextStyle(
                      color: AppColors.appWhiteColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () => Common.showOnePrimaryButtonDialog(
                    context: context,
                    dialogMessage:
                        "Are you sure you want to delete the food item?",
                    primaryButtonText: "Yes, Delete Now",
                    onPressed: () async {
                      Common.pop(context);
                      await ApiRequests.deleteProduct(
                        foodItem,
                        context: context,
                      );
                    },
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.appBlueColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: AppColors.appWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            "${foodItem.title}",
            style: TextStyle(
              color: AppColors.appBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Text(
            "${foodItem.description}",
            style: TextStyle(
              color: AppColors.appBlackColor,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "Item Price: \$${foodItem.discountedPrice}",
                style: TextStyle(
                  color: AppColors.appBlackColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  "",
                  style: TextStyle(color: AppColors.appGreyColor),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Divider(thickness: 1.0),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
