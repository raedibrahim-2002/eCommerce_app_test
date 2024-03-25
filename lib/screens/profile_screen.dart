import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/database/shared_prefrences.dart';
import 'package:task33_complete_from_my_frien/screens/login_screen.dart';
import 'package:task33_complete_from_my_frien/screens/saved_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 25.sp,
          horizontal: 15.sp,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PreferenceUtils.getString(PrefKeys.userName),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                PreferenceUtils.getString(PrefKeys.userEmail),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 25.sp),
              profileItemBuilder(
                title: 'Edit Profile',
                icon: Icons.edit_outlined,
                screen: const SizedBox(),
              ),
              profileItemBuilder(
                title: 'Settings',
                icon: Icons.settings,
                screen: const SizedBox(),
              ),
              profileItemBuilder(
                title: 'Saved Items',
                icon: Icons.favorite_border_outlined,
                screen: const SavedItems(),
              ),
              profileItemBuilder(
                title: 'Orders',
                icon: Icons.shopping_cart_checkout,
                screen: const SizedBox(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  logout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                label: Text(
                  "LogOut",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                icon: Icon(
                  Icons.logout,
                  size: 22.sp,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileItemBuilder(
      {required String title, required IconData icon, required Widget screen}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.sp,
      padding: EdgeInsets.all(15.sp),
      margin: EdgeInsets.only(bottom: 17.sp),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 242, 219, 0.8),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.orange,
            size: 22.sp,
          ),
          SizedBox(width: 20.sp),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color.fromRGBO(255, 217, 146, 1),
              elevation: 0,
            ),
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    PreferenceUtils.setString(PrefKeys.apiToken, '');
    PreferenceUtils.setString(PrefKeys.userName, '');
    PreferenceUtils.setString(PrefKeys.userEmail, '');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}
