import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyWidget extends StatelessWidget {
  final String text;
  final String string;

  const CopyWidget({Key? key, required this.text, required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      splashRadius: 25,
      onPressed: (){
        Clipboard.setData(ClipboardData(text: text))
          .then((value){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$string copied to Clipboard'),
                margin: const EdgeInsets.all(20),
                behavior: SnackBarBehavior.floating,
                elevation: 12,
                )
              );
          });
      }, 
      icon: const Icon(Icons.content_copy)
    );
  }
}