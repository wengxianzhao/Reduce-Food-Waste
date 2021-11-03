import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class FoodItem extends StatefulWidget {
  final FoodItemModal foodItem;
  final UserModal user;

  const FoodItem({
    Key? key,
    required this.foodItem,
    required this.user,
  }) : super(key: key);

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  bool _isCartLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Common.push(
          context,
          ProductDetail(
            foodItem: widget.foodItem,
            user: widget.user,
          )),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "${widget.foodItem.imageUrl}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${widget.foodItem.title}",
                      style: TextStyle(
                        color: AppColors.appBlackColor,
                        fontSize: 17.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.5),
                    Text(
                      "${widget.foodItem.category}",
                      style: TextStyle(
                        color: AppColors.appBlueColor.withOpacity(0.8),
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "\$${widget.foodItem.originalPrice}",
                              style: TextStyle(
                                color: AppColors.appBlackColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              "\$${widget.foodItem.discountedPrice}",
                              style: TextStyle(
                                color: AppColors.appBlackColor,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => _processCartIconOrder(),
                          child: _isCartLoading
                              ? CupertinoActivityIndicator()
                              : Icon(
                                  Icons.shopping_cart_outlined,
                                  color: AppColors.appGreyColor,
                                  size: 22.0,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 10.0,
            top: 10.0,
            child: FavouriteItemCard(itemID: widget.foodItem.id),
          ),
        ],
      ),
    );
  }

  void _processCartIconOrder() async {
    _isCartLoading = true;
    setState(() {});

    await ApiRequests.processOrder(widget.user.id, widget.foodItem.foodPostedBy,
        widget.foodItem.foodPostedBy, 1, widget.foodItem.discountedPrice,
        context: context);

    _isCartLoading = false;
    setState(() {});
  }
}
