
import 'package:flutter/material.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {

  String url;
  String title;
  WebViewScreen({super.key, required this.url, required this.title});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Resources.textStyle.koHoSmallLightText(
        color: Resources.color.textColor,
          fontSize: 14,
        ),),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}