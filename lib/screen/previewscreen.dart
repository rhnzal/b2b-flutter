import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 22, 29),
        title: const Text('Preview'),
      ),
      // body: Center(child: Text('Tes')),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
      ),
    );
  }
}
