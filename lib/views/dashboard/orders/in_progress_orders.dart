import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class InProgressOrders extends StatelessWidget {
  final UserModal user;
  const InProgressOrders({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "In Progress Orders",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: ApiRequests.getOrders(Common.IN_PROGRESS, user),
                builder: (context, snapshot) {
                  if (!(snapshot.hasData))
                    return LoadingInProgressOrderCardList();
                  if (snapshot.data?.docs.length == 0)
                    return NoDataFound(
                      title: "No In Progress Orders",
                      description:
                          "Goto Dashboard and explore variety of food items at affordable cost. Enjoy Healthy Eating :)",
                    );
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot orderDocument =
                          snapshot.data!.docs[index];
                      OrderModal order = OrderModal.fromJson(
                          orderDocument.data() as Map<String, dynamic>);
                      return OrderCard(
                        order: order,
                        user: user,
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
