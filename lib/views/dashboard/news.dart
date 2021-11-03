import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class News extends StatelessWidget {
  final UserModal user;
  const News({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ApiRequests.getNews(),
        builder: (context, snapshot) {
          if (!(snapshot.hasData))
            return SafeArea(child: LoadingNewsCardList());
          if (snapshot.data?.docs.length == 0)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  "${Common.assetsAnimations}not_found.json",
                  height: 150.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "No News Available",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "We're working to provide you most relevant and up-to-date news, keep checking the tab to read news.",
                  style: TextStyle(color: AppColors.appGreyColor),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot newsItemDocument = snapshot.data!.docs[index];
              NewsModal newsItem = NewsModal.fromJson(
                  newsItemDocument.data() as Map<String, dynamic>);
              return Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          '${newsItem.imageUrl}',
                          fit: BoxFit.fill,
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
                            '${newsItem.title}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appBlackColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            '${newsItem.description}',
                            style: TextStyle(
                              color: AppColors.appGreyColor,
                              fontSize: 15.0,
                            ),
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
