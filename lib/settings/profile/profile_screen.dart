import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_button.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/common/common_widgets/input_field.dart';
import 'package:uton_flutter/common/models/user.dart' as app_user;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  app_user.User? user;
  bool _isEditMode = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      setState(() {
        user = app_user.User(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          email: firebaseUser.email,
          phoneNumber: firebaseUser.phoneNumber,
          photoURL: firebaseUser.photoURL,
        );
      });
    }
  }

  void _editProfile() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageAsset("background.png", fit: BoxFit.fitWidth, width: getScreenSize(context).width, height: getScreenSize(context).height),
        Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            title: AppText("profile_title".tr(), textStyle: Resources.textStyle.koHoTitleText(), textAlign: TextAlign.center),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: _mainContent(context),
        ),
      ],
    );
  }

  Widget _mainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Global.mainPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('profile_name'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            if (_isEditMode) InputField(controller: _nameController, inputType: InputType.name)
            else Text(user?.displayName ?? 'John Doe', style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Text('profile_email'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            if(_isEditMode) InputField(controller: _emailController, inputType: InputType.email)
            else Text(user?.email ?? 'john.doe@example.com', style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Text('profile_phone'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            if(_isEditMode) InputField(controller: _phoneController, inputType: InputType.phone)
            else Text(user?.phoneNumber ?? '+1 234 567 890', style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Text('profile_address'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            if(_isEditMode) InputField(controller: _addressController, inputType: InputType.address)
            else Text(user?.address ?? 'Budapest', style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Text('profile_birthdate'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            if(_isEditMode) InputField(controller: _birthdateController, inputType: InputType.birthdate)
            else Text(DateFormat('yyyy-MM-dd').format(user?.birthdate ?? DateTime.now()), style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Text('profile_gender'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            if(_isEditMode) InputField(controller: _addressController, inputType: InputType.gender)
            else Text(user?.gender ?? 'férfi', style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            AppButton(text: _isEditMode ? 'profile_save'.tr() : 'profile_edit'.tr(), onPressed:() {
              _editProfile();
            }),
          ],
        ),
      ),
    );
  }
}
