import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/modals/modals_exporter.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserModal? _user;
  bool _isLoading = true;
  int _currentIndex = 0;
  PageController _pageController = new PageController();
  List<Widget> _screens = [];

  @override
  void initState() {
    _getUserDetails();
    // update page controller from start if needed
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: _isLoading ? const SizedBox() : RFWDrawer(user: _user!),
      extendBodyBehindAppBar: true,
      body: _isLoading
          ? CupertinoActivityIndicator()
          : SizedBox.expand(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: _screens,
                ),
              ),
            ),
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          backgroundColor: AppColors.appBlueColor,
          selectedIndex: _currentIndex,
          showElevation: true,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                'Home',
                textAlign: TextAlign.center,
              ),
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                'Maps',
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.location_on),
            ),
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                "Favourite",
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.favorite),
            ),
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                'News',
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.art_track_sharp),
            ),
            BottomNavyBarItem(
              activeColor: AppColors.appWhiteColor,
              inactiveColor: Colors.blue,
              title: Text(
                'Profile',
                textAlign: TextAlign.center,
              ),
              icon: Icon(Icons.account_circle_rounded),
            ),
          ],
        ),
      ),
    );
  }

  void _getUserDetails() async {
    _user = await ApiRequests.getLoggedInUser();
    _screens = [
      Home(user: _user!),
      ProductsMap(user: _user!),
      Favourite(user: _user!),
      News(user: _user!),
      Profile(user: _user!),
    ];

    _isLoading = false;
    setState(() {});
  }
}
