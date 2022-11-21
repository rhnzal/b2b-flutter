import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:projectb2b/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late WebViewController controller ;
  
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       systemOverlayStyle: SystemUiOverlayStyle.light,
  //       backgroundColor: const Color.fromARGB(255, 23, 22, 29),
  //       title: const Text('Preview'),
  //     ),
  //     body: PhotoView(
  //       imageProvider: NetworkImage(widget.url),
  //       backgroundDecoration: const BoxDecoration(
  //         color:Color.fromARGB(255, 224, 232, 235)
  //       ),
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Widget title = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Looking For Smoothie Blender',
            style: MengStyle().mengBig,
            textAlign: TextAlign.center,
          ),
          Text(
            'Nov 20, 2022',
            style: MengStyle().mengSmall,
          ),
        ]
      )
    );

    Widget card = Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,15,20,15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Purchaser',
                style: MengStyle().mengSmall,
              ),
              const SizedBox(height: 5),
              Text(
                'Rojas',
                style: MengStyle().mengBig,
              ),
              const SizedBox(height: 20),

              // Country
              Text(
                'Country',
                style: MengStyle().mengSmall,
              ),
              const SizedBox(height: 5),
              Text(
                'USA',
                style: MengStyle().mengBig,
              ),
              const SizedBox(height: 20),

              // contact
              Text(
              'Contact Number',
              style: MengStyle().mengSmall,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '205-200-0203',
                    style: MengStyle().mengBig,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 25,
                    onPressed: (){}, 
                    icon: const Icon(Icons.content_copy)
                  ),
                ],
              ),
              const SizedBox(height: 20),

              //Company Name
              Text(
              'Company Name',
              style: MengStyle().mengSmall,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Master Pipe',
                    style: MengStyle().mengBig,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 25,
                    onPressed: (){}, 
                    icon: const Icon(Icons.content_copy)
                  ),
                ],
              ),
              const SizedBox(height: 20),

              //posted
              Text(
                'Posted',
                style: MengStyle().mengSmall,
              ),
              const SizedBox(height: 5),
              Text(
                'Nov 19, 2022',
                style: MengStyle().mengBig,
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                'Description',
                style: MengStyle().mengSmall,
              ),
              const SizedBox(height: 5),
              Text(
                'Looking for mixer portable bottle blender',
                style: MengStyle().mengBig,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      )
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      appBar:  AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: const Color.fromARGB(255, 23, 22, 29),
        title: const Text('Preview'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          title,
          card
        ],
      ),
    );
  }
}
