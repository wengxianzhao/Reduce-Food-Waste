import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:reduce_food_waste/views/utils/widgets/widgets_exporter.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _usernameController = TextEditingController();
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
                    vertical: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appWhiteColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LabelAndInputField(
                          label: "Enter Username",
                          fieldController: _usernameController,
                        ),
                        const SizedBox(height: 12.0),
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
                        const SizedBox(height: 25.0),
                        PrimaryButton(
                          onPressed: () => _processRegister(),
                          buttonText: 'Register',
                        ),
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            "Already Have an account? Login Now!",
                            style: TextStyle(
                              color: AppColors.appBlackColor.withOpacity(0.7),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
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

  Future<void> _processRegister() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String uid = _uidController.text.trim();

    if (username.isEmpty)
      Common.showErrorTopSnack(
          context, "Please provide Username and try again");
    else if (email.isEmpty ||
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
      await ApiRequests.registerUser(context, username, email, uid)
          .then(
        (value) => Common.pushAndRemoveUntil(
          context,
          Dashboard(),
        ),
      )
          .onError((error, stackTrace) {
        _isLoading = false;
        setState(() {});
        Common.showErrorTopSnack(context, error.toString());
      });
    }
  }
}
