import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class PostProduct extends StatefulWidget {
  final UserModal user;
  PostProduct({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _originalPriceController = TextEditingController();
  TextEditingController _discountedPriceController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  FoodCategory _category = Common.foodCategories.first;
  File? _selectedImage;
  String _address = "";
  bool _isLoading = false;

  @override
  void initState() {
    _getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Food"),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "${Common.assetsImages}application_icon.png",
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Post food for sale",
                              style: TextStyle(
                                color: AppColors.appBlackColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "\"Food & Love are meant for sharing not wasting\"",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.appGreyColor.withOpacity(0.15),
                        offset: Offset(1, 2),
                        spreadRadius: 20,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 8,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () => _pickImage(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.appGreyColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  height: 180.0,
                                  child: _selectedImage == null
                                      ? Center(
                                          child: Text(
                                            "Click To Upload Image",
                                          ),
                                        )
                                      : Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              LabelAndInputField(
                                fieldController: _titleController,
                                label: "Food Title",
                              ),
                              const SizedBox(height: 15.0),
                              LabelAndInputField(
                                fieldController: _descriptionController,
                                label: "Food Description",
                                maxLines: 4,
                              ),
                              const SizedBox(height: 15.0),
                              LabelAndInputField(
                                fieldController: _originalPriceController,
                                label: "Original Price",
                                inputType: TextInputType.number,
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$",
                                      style: TextStyle(
                                        color: AppColors.appBlackColor
                                            .withOpacity(0.5),
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              LabelAndInputField(
                                fieldController: _discountedPriceController,
                                label: "Discounted Price",
                                inputType: TextInputType.number,
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$",
                                      style: TextStyle(
                                        color: AppColors.appBlackColor
                                            .withOpacity(0.5),
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.appGreyColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 2.5,
                                ),
                                child: DropdownButton<FoodCategory>(
                                  underline: const SizedBox(),
                                  value: _category,
                                  isExpanded: true,
                                  icon:
                                      const Icon(Icons.arrow_drop_down_rounded),
                                  onChanged: (FoodCategory? newValue) {
                                    setState(() {
                                      _category = newValue!;
                                    });
                                  },
                                  items: Common.foodCategories
                                      .map<DropdownMenuItem<FoodCategory>>(
                                          (FoodCategory value) {
                                    return DropdownMenuItem<FoodCategory>(
                                      value: value,
                                      child: Text(value.title),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              LabelAndInputField(
                                fieldController: _addressController,
                                label: "Address",
                                maxLines: 3,
                              ),
                              const SizedBox(height: 15.0),
                              PrimaryButton(
                                onPressed: () => _processPostFoodItem(),
                                buttonText: "Post",
                              ),
                              const SizedBox(height: 15.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _isLoading ? LoadingOverlay() : const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _processPostFoodItem() async {
    String _foodTitle = _titleController.text.trim();
    String _foodDescription = _descriptionController.text.trim();
    String _originalPrice = _originalPriceController.text.trim();
    String _discountedPrice = _discountedPriceController.text.trim();
    String _addr = _addressController.text.trim();
    if (_selectedImage == null) {
      Common.showErrorTopSnack(
          context, "Please select food item image to continue.");
      return;
    } else if (_category.value == Common.foodCategories.first.value) {
      Common.showErrorTopSnack(context,
          "Please select relevant category from dropdown to continue.");
      return;
    } else if (_foodTitle.isEmpty) {
      Common.showErrorTopSnack(
          context, "Please add Food Item title to continue.");
      return;
    } else if (_foodDescription.isEmpty || _foodDescription.length < 20) {
      Common.showErrorTopSnack(context,
          "Please add Food Item description and at-least add 20 words to continue.");
      return;
    } else if (_originalPrice.isEmpty) {
      Common.showErrorTopSnack(context,
          "Please add item original item price in dollars to continue.");
      return;
    } else if (_discountedPrice.isEmpty) {
      Common.showErrorTopSnack(context,
          "Please add item discounted item price in dollars to continue.");
      return;
    } else if (_addr.isEmpty) {
      Common.showErrorTopSnack(context,
          "Please enter valid address of yours where user can come for order pickup.");
      return;
    } else {
      _isLoading = true;
      setState(() {});

      Geolocator.getCurrentPosition().then((value) async {
        double _latitude = value.latitude;
        double _longitude = value.longitude;
        await ApiRequests.uploadSelectedImage(_selectedImage!)
            .then((value) async {
          await ApiRequests.postFoodItem(
            widget.user.id,
            _foodTitle,
            _category.value,
            double.parse(_discountedPrice),
            double.parse(_originalPrice),
            _foodDescription,
            _addr,
            _latitude,
            _longitude,
            value,
            context: context,
          );
          _isLoading = false;
          setState(() {});
          Common.showSuccessTopSnack(
            context,
            "Food Item posted successfully !",
          );
          Future.delayed(Duration(seconds: 2), () => Common.pop(context));
        });
      }).onError((error, stackTrace) {
        _isLoading = false;
        setState(() {});

        Common.showErrorTopSnack(context, "$error");

        Future.delayed(Duration(seconds: 3), () => Common.pop(context));
      });
    }
  }

  Future<void> _pickImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) _selectedImage = File(image.path);
    setState(() {});
  }

  Future<void> _getAddress() async {
    _address = await Common.getCurrentAddress(context);
    _addressController.text = _address;
    setState(() {});
  }
}
