import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/routes/app_routes.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _uidController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appBlueColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "${Common.assetsImages}application_icon.png",
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "${Common.applicationName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22.0,
                          color: AppColors.appWhiteColor,
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Text(
                        "Quality Food Available At Discounted Price",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.appWhiteColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 0.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30.0),
                      LabelAndInputField(
                        label: "Enter Email-Address",
                        fieldController: _emailController,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12.0),
                      LabelAndInputField(
                        label: "Enter Password",
                        fieldController: _uidController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.forgetPasswordRoute),
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors.appBlueColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      PrimaryButton(
                        onPressed: () => _processLogin(),
                        buttonText: 'Login',
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.registerRoute),
                        child: Text(
                          "Don't have an account? Create Now !",
                          style: TextStyle(
                            color: AppColors.appBlackColor.withOpacity(0.7),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      PrimaryButton(
                        onPressed: () => _processGoogleLogin(),
                        buttonColor: AppColors.appWhiteColor,
                        buttonText: 'Sign in with google',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "${Common.assetsIcons}googleG.png",
                              height: 25.0,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              "Sign in with google",
                              style: TextStyle(
                                color: AppColors.appBlackColor.withOpacity(0.7),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
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

  void _processLogin() {
    String email = _emailController.text.trim();
    String uid = _uidController.text.trim();

    if (email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email))
      Common.showErrorTopSnack(
          context, "Please provide valid Email-Address and try again");
    else if (uid.isEmpty)
      Common.showErrorTopSnack(
          context, "Please provide strong password and try-again");
    else {
      _isLoading = true;
      setState(() {});

      ApiRequests.loginUser(context, email, uid)
          .then((value) => Common.pushAndRemoveUntil(context, Dashboard()))
          .onError(
            (error, stackTrace) => Common.showErrorTopSnack(
              context,
              "Unable to login. please try again by double checking your email-address and password.",
            ),
          );
    }
  }

  void _processGoogleLogin() {
    setState(() {
      _isLoading = true;
    });
    ApiRequests.googleLogin().then((value) async {
      final user = await ApiRequests.getLoggedInUser();
      setState(() {
        _isLoading = false;
      });

      Common.pushAndRemoveUntil(context, Dashboard());
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      Common.showOnePrimaryButtonDialog(
        context: context,
        dialogMessage: error.toString(),
      );
    });
  }
}
