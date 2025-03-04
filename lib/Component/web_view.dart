import 'package:flutter/material.dart';
import 'package:kids_learning/Component/appBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final String title;
  final String url;

  const AppWebView({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  _AppWebViewState createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(title: widget.title),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
