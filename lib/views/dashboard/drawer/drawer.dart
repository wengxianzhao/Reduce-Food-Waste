import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class RFWDrawer extends StatelessWidget {
  final UserModal user;
  const RFWDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.appWhiteColor),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appBlueColor,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 45.0,
                      backgroundImage: (user.imageUrl == null ||
                              user.imageUrl!.isEmpty)
                          ? AssetImage(
                              "${Common.assetsImages}application_icon.png")
                          : NetworkImage("${user.imageUrl}") as ImageProvider,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "${user.username}",
                      style: TextStyle(
                        color: AppColors.appWhiteColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "${user.emailAddress}",
                      style: TextStyle(
                        color: AppColors.appWhiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DrawerListTile(
                      icon: Icons.home,
                      title: "Home",
                      onPressed: () => Common.pop(context),
                    ),
                    DrawerListTile(
                      icon: Icons.add_business,
                      title: "Sell Food",
                      onPressed: () {
                        Common.pop(context);
                        Common.push(context, PostProduct(user: user));
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.archive_sharp,
                      title: "Posted Food Items",
                      onPressed: () {
                        Common.pop(context);
                        Common.push(context, PostedProducts(user: user));
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.assignment_turned_in_rounded,
                      title: "Completed Orders",
                      onPressed: () {
                        Common.pop(context);
                        Common.push(context, CompletedOrders(user: user));
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.assignment_rounded,
                      title: "In Progress Orders",
                      onPressed: () {
                        Common.pop(context);
                        Common.push(context, InProgressOrders(user: user));
                      },
                    ),
                    DrawerListTile(
                      icon: Icons.door_back_door,
                      title: "Logout",
                      onPressed: () async {
                        await ApiRequests.logout();
                        Common.pushAndRemoveUntil(context, Login());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
