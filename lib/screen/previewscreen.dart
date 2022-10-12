import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late WebViewController controller ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 22, 29),
        title: const Text('Preview'),
      ),
      // body: Center(child: Text('Tes')),
      body: AbsorbPointer(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController controller){
            this.controller = controller;
          },
          onPageFinished: (url) {
              controller.runJavascript(
              "javascript:(function() { var head = document.getElementsByTagName('header')[0];head.parentNode.removeChild(head);var footer = document.getElementsByTagName('footer')[0];footer.parentNode.removeChild(footer);var register = document.getElementsByClassName('top-signup-bar-mobile hidden-lg hidden-md hidden-sm')[0];register.parentNode.removeChild(register);var wbg = document.getElementsByClassName('wbg')[0];wbg.parentNode.removeChild(wbg);var contact = document.getElementsByClassName('my_contact_us')[0];contact.parentNode.removeChild(contact);var breadcrumb = document.getElementsByClassName('breadcrumb')[0];breadcrumb.parentNode.removeChild(breadcrumb);})()"
            );
          },
        ),
      ),
    );
  }
}
