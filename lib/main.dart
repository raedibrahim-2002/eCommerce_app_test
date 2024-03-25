import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/database/shared_prefrences.dart';

import 'package:task33_complete_from_my_frien/screens/amazon_screen.dart';
import 'package:task33_complete_from_my_frien/screens/login_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  AppDio.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.orange,
        ),
        home: PreferenceUtils.getString(PrefKeys.apiToken) == ''
            ? const LoginScreen()
            : const AmazonScreen(),
      ),
    );
  }
}
