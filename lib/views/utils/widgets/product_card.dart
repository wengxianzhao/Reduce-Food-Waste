import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/dashboard/product/product_detail.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class ProductCard extends StatelessWidget {
  final FoodItemModal foodItem;
  final UserModal user;
  const ProductCard({
    Key? key,
    required this.foodItem,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Common.push(
        context,
        ProductDetail(foodItem: foodItem, user: user),
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 165.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        '${foodItem.imageUrl}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${foodItem.title}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appBlackColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 7.0),
                      Text(
                        '${foodItem.description}',
                        style: TextStyle(
                          color: AppColors.appGreyColor,
                          fontSize: 15.0,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.appGreyColor.withOpacity(0.6),
                            size: 18.0,
                          ),
                          Expanded(
                            child: Text(
                              '${foodItem.location.address}',
                              style: TextStyle(
                                color: AppColors.appGreyColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "\$${foodItem.originalPrice}",
                                  style: TextStyle(
                                    color: AppColors.appBlackColor,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  "\$${foodItem.discountedPrice}",
                                  style: TextStyle(
                                    color: AppColors.appBlackColor,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.appGreyColor,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: FavouriteItemCard(itemID: foodItem.id),
          ),
        ],
      ),
    );
  }
}
