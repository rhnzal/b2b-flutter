import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb2b/style.dart';
import 'package:projectb2b/widget/copy.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewScreen extends StatefulWidget {
  final List activity;
  final int index;
  final String date;

  const PreviewScreen({Key? key, required this.activity, required this.index, required this.date}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late WebViewController controller ;
    late String titleDoc = widget.activity[widget.index]["title"];
    late String purchaser = widget.activity[widget.index]["purchaser"];
    late String country = widget.activity[widget.index]["country"];
    late String contactNumber = widget.activity[widget.index]["contact"];
    late String companyName = widget.activity[widget.index]["company"];
    late String posted = widget.activity[widget.index]["posted"];
    late String desc = widget.activity[widget.index]["desc"];

  @override
  Widget build(BuildContext context) {
    Widget title = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            titleDoc,
            style: MengStyle().mengBig,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.date,
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
                purchaser,
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
                country,
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
                    contactNumber,
                    style: MengStyle().mengBig,
                  ),
                  CopyWidget(
                    text: contactNumber, 
                    string: 'Contact Number'
                  )
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
                    companyName,
                    style: MengStyle().mengBig,
                  ),
                  CopyWidget(
                    text: companyName, 
                    string: 'Company Name'
                  )
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
                posted,
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
                desc,
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
