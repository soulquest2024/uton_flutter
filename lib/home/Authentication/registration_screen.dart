

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_button.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/input_field.dart';
import 'package:uton_flutter/common/firestore/firebase_authentication.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
          _mainContent(),
        ],
      ),
    );
  }

  Widget _mainContent() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppText(
          "registration_title".tr(),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InputField(controller: _nameController, inputType: InputType.name),
                SizedBox(height: 10),
                InputField(controller: _emailController, inputType: InputType.email),
                SizedBox(height: 10),
                InputField(controller: _addressController, inputType: InputType.address),
                SizedBox(height: 10),
                InputField(controller: _birthdateController, inputType: InputType.birthdate),
                SizedBox(height: 10),
                InputField(controller: _genderController, inputType: InputType.gender),
                SizedBox(height: 20),
                InputField(controller: _passwordController, inputType: InputType.password),
                SizedBox(height: 20),
                InputField(controller: _passwordRetypeController, inputType: InputType.passwordRetype),
                SizedBox(height: 20),
                AppButton(text: "registration_button".tr(), onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_passwordController.text != _passwordRetypeController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                          "password_not_match".tr())));
                      return;
                    }
                    locator<FirebaseAuthentication>().registerUser(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                        _addressController.text,
                        _birthdateController.text,
                        _genderController.text);
                  }
                }),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('registration_login'.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
