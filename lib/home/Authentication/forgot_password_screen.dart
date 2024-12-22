
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_button.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _retypeNewPasswordController = TextEditingController();

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
          "forgot_title".tr(),
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
              AppText(
                "forgot_instruction".tr(),
                textStyle: Resources.textStyle.koHoSmallText(
                  color: Resources.color.textColor,
                  isBold: true,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              InputField(controller: _emailController, inputType: InputType.email),
              SizedBox(height: 10),
              AppButton(text: "forgot_button".tr(), onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('forgot_empty_email'.tr())),
                  );
                  return;
                }

                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('forgot_email_sent'.tr())),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage;
                  switch (e.code) {
                    case 'user-not-found':
                      errorMessage = 'forgot_email_not_found'.tr();
                      break;
                    case 'invalid-email':
                        errorMessage = 'forgot_email_format'.tr();
                      break;
                    default:
                      errorMessage = 'forgot_email_error'.tr();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

