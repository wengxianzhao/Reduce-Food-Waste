import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class OrderCard extends StatefulWidget {
  final OrderModal order;
  final UserModal user;

  const OrderCard({
    Key? key,
    required this.order,
    required this.user,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  FoodItemModal? _foodItem;
  bool _isLoading = true;

  @override
  void initState() {
    _getFoodItemDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CupertinoActivityIndicator()
        : InkWell(
            onTap: () => Common.push(
              context,
              OrderDetail(order: widget.order, foodItem: _foodItem!, user: widget.user,),
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
                          image: NetworkImage(_foodItem!.imageUrl),
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
                          "${widget.order.status}",
                          style: TextStyle(
                            color: AppColors.appWhiteColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  "${_foodItem!.title}",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Order Amount: \$${widget.order.price}",
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

  Future<void> _getFoodItemDetails() async {
    _foodItem = await ApiRequests.getFoodItemDetail(widget.order.foodItemId);
    _isLoading = false;
    setState(() {});
  }
}
