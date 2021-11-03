import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/routes/app_routes.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class Profile extends StatefulWidget {
  final UserModal user;
  const Profile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;
  bool _isProfileUploading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _pickImage(),
                    child: _isProfileUploading
                        ? CupertinoActivityIndicator()
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50.0,
                            backgroundImage: (widget.user.imageUrl == null ||
                                    widget.user.imageUrl!.isEmpty)
                                ? AssetImage(
                                        "${Common.assetsImages}application_icon.png")
                                    as ImageProvider
                                : NetworkImage(widget.user.imageUrl!),
                          ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "${widget.user.username}",
                  style: TextStyle(
                    color: AppColors.appBlackColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "${widget.user.emailAddress}",
                  style: TextStyle(
                    color: AppColors.appGreyColor.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 60.0),
            ProfileCard(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.onBoardingRoute),
              title: "On-Boarding",
              description:
                  "Introduction of application idea and Visual Graphics to explain the initiative and cause associated with it.",
            ),
            const SizedBox(height: 4.0),
            ProfileCard(
              title: "Terms And Conditions",
              description:
                  "Introduction of application idea and Visual Graphics to explain the initiative and cause associated with it.",
            ),
            const SizedBox(height: 4.0),
            ProfileCard(
              title: "Privacy Policy",
              description:
                  "We value your privacy and believe in security of your data. you can read our privacy policy in details here",
            ),
            const SizedBox(height: 4.0),
            ProfileCard(
              onPressed: () => _processLogout(),
              title: "Logout",
              description:
                  "Hope to see you back soon. Keep exploring for quality food in discounted price.",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    _isProfileUploading = true;
    setState(() {});
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      String path = await ApiRequests.uploadSelectedImage(_selectedImage!);
      await ApiRequests.updateUserProfilePicture(widget.user, path);
      Common.showSuccessTopSnack(context, "Profile picture updated");
      Future.delayed(
        Duration(seconds: 3),
        () => Common.pushAndRemoveUntil(
          context,
          Dashboard(),
        ),
      );
    }
    _isProfileUploading = false;
    setState(() {});
  }

  void _processLogout() async {
    await ApiRequests.logout();
    Common.pushAndRemoveUntil(context, Login());
  }
}

class ProfileCard extends StatelessWidget {
  final String title, description;
  final VoidCallback? onPressed;

  const ProfileCard({
    Key? key,
    required this.title,
    required this.description,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.appGreyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "$title",
                    style: TextStyle(
                      color: AppColors.appBlackColor.withOpacity(0.65),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 40.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: AppColors.appGreyColor.withOpacity(0.5),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              "$description",
              style: TextStyle(
                color: AppColors.appGreyColor,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
