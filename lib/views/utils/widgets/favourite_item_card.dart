import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class FavouriteItemCard extends StatefulWidget {
  final String itemID;

  const FavouriteItemCard({
    Key? key,
    required this.itemID,
  }) : super(key: key);

  @override
  State<FavouriteItemCard> createState() => _FavouriteItemCardState();
}

class _FavouriteItemCardState extends State<FavouriteItemCard> {
  UserModal? _user;
  bool _isLoading = true;

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CupertinoActivityIndicator()
        : StreamBuilder<QuerySnapshot>(
            stream:
                ApiRequests.getFavouriteItemByUser(_user!.id, widget.itemID),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CupertinoActivityIndicator();
              return FavouriteIcon(
                itemID: widget.itemID,
                userID: _user!.id,
                isSelected: snapshot.data?.docs.length != 0,
              );
            },
          );
  }

  void _getUserDetails() async {
    _user = await ApiRequests.getLoggedInUser();
    _isLoading = false;
    setState(() {});
  }
}
