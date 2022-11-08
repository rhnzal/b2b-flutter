import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
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
      body: PhotoView(
        imageProvider: NetworkImage(widget.url),
        backgroundDecoration: const BoxDecoration(
          color:Color.fromARGB(255, 224, 232, 235)
        ),
      )
    );
  }
}
