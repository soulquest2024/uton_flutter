
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_button.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/input_field.dart';
import 'package:uton_flutter/common/firestore/firebase_authentication.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';
import 'package:uton_flutter/home/Authentication/forgot_password_screen.dart';
import 'package:uton_flutter/home/Authentication/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Stack(
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
          _mainContent(),
        ],
      )
    );
  }

  Widget _mainContent() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppText(
          "login_title".tr(),
          textStyle: Resources.textStyle.koHoTitleText(
            color: Resources.color.textColor,
            isBold: true,
          ),
          textAlign: TextAlign.end,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputField(controller: _emailController, inputType: InputType.email,),
              SizedBox(height: 10),
              InputField(controller: _passwordController, inputType: InputType.password),
              SizedBox(height: 20),
              AppButton(text: 'login_button'.tr(), onPressed:() {
                locator<FirebaseAuthentication>().loginUser(_emailController.text, _passwordController.text);
              }),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => locator<ForgotPasswordScreen>()),
                  );
                },
                child: Text('login_forgot'.tr()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => locator<RegistrationScreen>()),
                  );
                },
                child: Text('login_register'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
