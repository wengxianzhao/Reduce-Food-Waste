import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class ProductDetail extends StatefulWidget {
  final FoodItemModal foodItem;
  final UserModal user;
  const ProductDetail({
    Key? key,
    required this.foodItem,
    required this.user,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isLoading = false;
  int purchaseItemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
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
                        top: 20.0,
                        left: 20.0,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.appWhiteColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.appGreyColor.withOpacity(0.6),
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
                            const SizedBox(width: 20.0),
                            FavouriteItemCard(itemID: widget.foodItem.id),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
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
                                vertical: 5,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90.0,
                              decoration: BoxDecoration(
                                color: AppColors.appBlueColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (purchaseItemCount != 1)
                                        purchaseItemCount--;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        10.0,
                                        6.0,
                                        0.0,
                                        6.0,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$purchaseItemCount',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (!(purchaseItemCount >= 9))
                                        purchaseItemCount++;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                        0.0,
                                        6.0,
                                        10.0,
                                        6.0,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Text(
                                    '\$${widget.foodItem.originalPrice}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'MontserratBlack',
                                      fontSize: 25.0,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '\$${widget.foodItem.discountedPrice}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'MontserratBlack',
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isLoading ? LoadingOverlay() : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: _isLoading
          ? const SizedBox()
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
                    child: InkWell(
                      onTap: () => Common.pop(context),
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
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _processOrder(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                            color: AppColors.appWhiteColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'MontserratBlack',
                            fontSize: 18.0,
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

  void _processOrder() async {
    _isLoading = true;
    setState(() {});

    await ApiRequests.processOrder(
        widget.user.id,
        widget.foodItem.foodPostedBy,
        widget.foodItem.foodPostedBy,
        purchaseItemCount,
        widget.foodItem.discountedPrice,
        context: context,);

    _isLoading = false;
    setState(() {});
  }
}
