import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class ProductsMap extends StatefulWidget {
  final UserModal user;
  ProductsMap({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProductsMap> createState() => _ProductsMapState();
}

class _ProductsMapState extends State<ProductsMap> {
  List<Marker> _markers = <Marker>[];

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      1.3521,
      103.8198,
    ),
    zoom: 10,
  );
  bool _isLoading = true;

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _setupMapMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingOverlay()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: AppColors.appGreyColor.withOpacity(0.5),
                  child: GoogleMap(
                    markers: Set<Marker>.of(_markers),
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: ApiRequests.getFoodItems(0),
                      builder: (context, snapshot) {
                        if (!(snapshot.hasData))
                          return SafeArea(child: LoadingProductCardList());
                        if (snapshot.data?.docs.length == 0)
                          return NoDataFound(
                            title: "No Food Items Available",
                            description:
                                "Keep checking the app very soon new products will come up. Enjoy Healthy Eating :)",
                          );
                        return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot foodItemDocument =
                                snapshot.data!.docs[index];
                            FoodItemModal foodItem = FoodItemModal.fromJson(
                                foodItemDocument.data()
                                    as Map<String, dynamic>);
                            return ProductCard(
                              foodItem: foodItem,
                              user: widget.user,
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          );
  }

  void _setupMapMarkers() async {
    Geolocator.getCurrentPosition().then((value) {
      _kGooglePlex = CameraPosition(
        target: LatLng(
          value.latitude,
          value.longitude,
        ),
        zoom: 16,
      );
    });
    await ApiRequests.getAllFoodItems().then((value) {
      value.forEach((element) {
        _addMarker(element);
      });
    });
    _isLoading = false;
    setState(() {});
  }

  void _addMarker(FoodItemModal foodItem) {
    _markers.add(
      Marker(
        markerId: MarkerId(foodItem.id),
        position:
            LatLng(foodItem.location.latitude, foodItem.location.longitude),
        infoWindow: InfoWindow(title: '${foodItem.title}'),
      ),
    );
  }
}
