
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
      [
        imageAsset("background.png", fit: BoxFit.fitWidth, width: getScreenSize(context).width, height: getScreenSize(context).height),
        _mainContent()
      ],
    );
  }

  Widget _mainContent() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          //_profileTile(),
          //_logoutTile(),
          // Add more tiles for other settings options
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
    // For example, clear user session and navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}