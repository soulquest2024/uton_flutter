import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';

enum InputType {
  email,
  password,
  passwordRetype,
  name,
  address,
  birthdate,
  gender,
}

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final InputType inputType;
  final bool obscureText;

  InputField({
    super.key,
    required this.controller,
    required this.inputType,
    this.obscureText = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isValidated = true;

  @override
  Widget build(BuildContext context) {
    return widget.inputType == InputType.birthdate || widget.inputType == InputType.gender
        ? GestureDetector(
      onTap: () async {
        if (widget.inputType == InputType.birthdate) {
          _onFocusChange();
        } else if (widget.inputType == InputType.gender) {
          _onFocusChangePicker();
        }
      },
      child: AbsorbPointer(
        child: _buildTextFormField(),
      ),
    )
        : _buildTextFormField();
  }

  Widget _buildTextFormField() {
    return Container(
      height: _isValidated ? 44 : 64,
      child: TextFormField(
        controller: widget.controller,
        focusNode: (widget.inputType == InputType.birthdate || widget.inputType == InputType.gender) ? _focusNode : null,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Resources.textStyle.koHoSmallText(
            color: Resources.color.hintTextColor,
            fontSize: 14,
          ),
          hintText: labelText,
          hintStyle: Resources.textStyle.koHoSmallText(
            color: Resources.color.hintTextColor,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Resources.color.primaryColor,
              width: 0.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.5,
            ),
          ),
        ),
        style: Resources.textStyle.koHoSmallText(
          color: Resources.color.textColor,
          fontSize: 14,
        ),
        keyboardType: widget.inputType == InputType.email ? TextInputType.emailAddress : TextInputType.text,
        obscureText: widget.inputType == InputType.password || widget.inputType == InputType.passwordRetype,
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _isValidated = false;
            });
            return validatorText;
          }
          if (widget.inputType == InputType.email && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            setState(() {
              _isValidated = false;
            });
            return "Invalid email format";
          }
          setState(() {
            _isValidated = true;
          });
          return null;
        },
      ),
    );
  }

  String get labelText {
    switch (widget.inputType) {
      case InputType.email:
        return 'registration_email'.tr();
      case InputType.password:
        return 'registration_password'.tr();
      case InputType.passwordRetype:
        return 'registration_password_retype'.tr();
      case InputType.name:
        return 'registration_name'.tr();
      case InputType.address:
        return 'registration_address'.tr();
      case InputType.birthdate:
        return 'registration_birthdate'.tr();
      case InputType.gender:
        return 'registration_gender'.tr();
    }
  }

  String get validatorText {
    switch (widget.inputType) {
      case InputType.email:
        return 'email_validation'.tr();
      case InputType.password:
        return 'password_validation'.tr();
      case InputType.passwordRetype:
        return 'password_retype_validation'.tr();
      case InputType.name:
        return 'email_validation'.tr();
      case InputType.address:
        return 'email_validation'.tr();
      case InputType.birthdate:
        return 'email_validation'.tr();
      case InputType.gender:
        return 'email_validation'.tr();
    }
  }

  void _onFocusChange() async {
    DateTime? pickedDate = await showDatePicker(
      context: _focusNode.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void _onFocusChangePicker() async {
    String? selectedGender = await showDialog<String>(
      context: _focusNode.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('gender_select'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('gender_male'.tr()),
                onTap: () => Navigator.pop(context, 'gender_male'.tr()),
              ),
              ListTile(
                title: Text('gender_female'.tr()),
                onTap: () => Navigator.pop(context, 'gender_female'.tr()),
              ),
            ],
          ),
        );
      },
    );
    if (selectedGender != null) {
      widget.controller.text = selectedGender;
    }
    _focusNode.unfocus();
  }
}