import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/database/shared_prefrences.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/login_response.dart';
import 'package:task33_complete_from_my_frien/screens/amazon_screen.dart';
import 'package:task33_complete_from_my_frien/screens/register_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';
import 'package:task33_complete_from_my_frien/utils/flutter_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.orange,
                alignment: Alignment.center,
                // child: SvgPicture.asset(
                //   'assets/images/Amazon_logo.svg',
                //   width: 32.sp,
                //   height: 32.sp,
                // ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25.sp),
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 2.sp),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email!";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.orange,
                          ),
                          label: Text(
                            "Email",
                            style: TextStyle(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      SizedBox(height: 15.sp),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password!";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: obscure,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.orange,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscure = !obscure;
                              setState(() {});
                            },
                            icon: Icon(
                              obscure == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.orange,
                            ),
                          ),
                          label: const Text(
                            "Password",
                            style: TextStyle(color: Colors.orange),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      SizedBox(height: 15.sp),
                      SizedBox(
                        width: double.infinity,
                        height: 30.sp,
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.sp)),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account?",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          TextButton(
                            onPressed: () {
                              navToRegister();
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final response = await AppDio.post(
      endPoint: EndPoints.login,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    final loginResponse = LoginResponse.fromJson(response.data);
    if (loginResponse.status) {
      PreferenceUtils.setString(PrefKeys.apiToken, loginResponse.data.token);
      PreferenceUtils.setString(PrefKeys.userName, loginResponse.data.name);
      PreferenceUtils.setString(PrefKeys.userEmail, loginResponse.data.email);
      navToHome();
    } else {
      showToast(loginResponse.message);
    }
  }

  void navToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  void navToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AmazonScreen(),
      ),
      (route) => false,
    );
  }
}
