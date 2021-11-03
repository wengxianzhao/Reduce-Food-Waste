import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/loading/loading_holder.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProductCard extends StatelessWidget {
  const LoadingProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              const SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: Shimmer.fromColors(
                  baseColor: AppColors.appGreyColor.withOpacity(0.25),
                  highlightColor: AppColors.appGreyColor.withOpacity(0.15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.appWhiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 150.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadingHolder(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        height: 10.0,
                      ),
                    ),
                    const SizedBox(height: 7.0),
                    LoadingHolder(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        height: 10.0,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    LoadingHolder(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    LoadingHolder(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.appGreyColor.withOpacity(0.6),
                          size: 18.0,
                        ),
                        LoadingHolder(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.appWhiteColor,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                            height: 10.0,
                            width: MediaQuery.of(context).size.width * 0.5,
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
                          Wrap(
                            children: [
                              Text(
                                "\$",
                                style: TextStyle(
                                  color: AppColors.appBlackColor,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              LoadingHolder(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.appWhiteColor,
                                    borderRadius: BorderRadius.circular(2.5),
                                  ),
                                  height: 30.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
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
              const SizedBox(width: 10.0),
            ],
          ),
        ),
        Positioned(
          top: 10.0,
          left: 20.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBlackColor.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(5.0),
            child: CupertinoActivityIndicator(),
          ),
        ),
      ],
    );
  }
}
