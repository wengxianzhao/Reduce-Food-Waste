import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class OrderDetail extends StatefulWidget {
  final OrderModal order;
  final FoodItemModal foodItem;
  final UserModal user;
  const OrderDetail({
    Key? key,
    required this.user,
    required this.order,
    required this.foodItem,
  }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  double _orderRating = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: Image.network(
                    '${widget.foodItem.imageUrl}',
                    fit: BoxFit.fill,
                    height: 350.0,
                  ),
                ),
                Positioned(
                  top: 30.0,
                  left: 20.0,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appWhiteColor.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appGreyColor.withOpacity(0.6),
                            blurRadius: 10.0,
                            spreadRadius: 10.0,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.appWhiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.foodItem.title}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30.0,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 18.0,
                        ),
                        margin: const EdgeInsets.only(right: 5.0),
                        child: Center(
                          child: Text(
                            '${widget.foodItem.category}',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Order Amount: \$${widget.order.price}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MontserratBlack',
                      fontSize: 26.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Quantity: ${widget.order.quantity}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MontserratBlack',
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${widget.foodItem.description}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  widget.order.status == Common.COMPLETED
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.appWhiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.appGreyColor.withOpacity(0.15),
                                offset: Offset(1, 2),
                                blurRadius: 5.0,
                                spreadRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Order:#${widget.order.id}",
                                style: TextStyle(
                                  color: AppColors.appBlackColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              RatingBar.builder(
                                initialRating: widget.order.rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 30.0,
                                itemCount: 5,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (double ratedValue) {},
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: (widget.order.status == Common.COMPLETED)
          ? const SizedBox.shrink()
          : Container(
              decoration: BoxDecoration(
                color: AppColors.appWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appGreyColor.withOpacity(0.2),
                    offset: Offset(1, 2),
                    spreadRadius: 10.0,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'CONTINUE EXPLORING',
                      style: TextStyle(
                        color: AppColors.appBlueColor,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'MontserratBlack',
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => (widget.order.foodItemUploaderID ==
                              widget.user.id)
                          ? Common.showOnePrimaryButtonDialog(
                              isDismissible: false,
                              context: context,
                              primaryButtonText: "Cancel Now",
                              onPressed: () async {
                                await ApiRequests.cancelOrder(widget.order);
                                Common.pushAndRemoveUntil(
                                  context,
                                  Dashboard(),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Customer Ordered food and he'll be at your location anytime. Are you sure you want to cancel the order?",
                                    style: TextStyle(
                                      color: AppColors.appBlackColor,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Common.showOnePrimaryButtonDialog(
                              isDismissible: false,
                              context: context,
                              primaryButtonText: "Done",
                              onPressed: () async {
                                await ApiRequests.completeOrder(
                                    widget.order, _orderRating);
                                Common.showSuccessTopSnack(context,
                                    "Order completed successfully. Enjoy your food :)");
                                Future.delayed(
                                  Duration(seconds: 3),
                                  () => Common.pushAndRemoveUntil(
                                    context,
                                    Dashboard(),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "We are glad that order is completed. Leave rating to encourage seller so he can keep providing discounted items :)",
                                    style: TextStyle(
                                      color: AppColors.appBlackColor,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Center(
                                    child: RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemSize: 30.0,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (double ratedValue) {
                                        _orderRating = ratedValue;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          (widget.order.foodItemUploaderID == widget.user.id)
                              ? "Cancel Order"
                              : "I\'ve Collected Food",
                          style: TextStyle(
                            color: AppColors.appWhiteColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'MontserratBlack',
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
