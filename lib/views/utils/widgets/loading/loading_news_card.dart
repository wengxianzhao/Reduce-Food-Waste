import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets_exporter.dart';

class LoadingNewsCard extends StatelessWidget {
  const LoadingNewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    height: 14.0,
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
                const SizedBox(height: 2.0),
                LoadingHolder(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.appWhiteColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    height: 10.0,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
