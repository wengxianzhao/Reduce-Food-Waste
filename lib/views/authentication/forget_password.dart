import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailController = TextEditingController();
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        SizedBox(height: 5),
                        Text(
                          "Provide is the Email-Address and we'll send confirmation link to you.",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.appWhiteColor.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelAndInputField(
                        label: "Enter Email-Address",
                        fieldController: _emailController,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 25.0),
                      PrimaryButton(
                        onPressed: () => _processForgetPassword(),
                        buttonText: 'Recover Password',
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

  void _processForgetPassword() async {
    String email = _emailController.text.trim();
    if (email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email))
      Common.showErrorTopSnack(
          context, "Please provide valid email-address and try again");
    else {
      _isLoading = true;
      setState(() {});
      await ApiRequests.sendResetPasswordCode(context, email);
      _isLoading = false;
      setState(() {});
    }
  }
}
