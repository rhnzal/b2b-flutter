import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key, this.pad = 150}) : super(key: key);
  
  final double pad;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: widget.pad),
      child: const CircularProgressIndicator(
        color: Color.fromARGB(255, 23, 22, 29),
      )
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({Key? key, this.pad = 150}) : super(key: key);
  final double pad;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: pad),
      child: const Icon(
        Icons.folder_off_outlined, 
        size: 60, 
        color: Color.fromARGB(255, 26, 25, 32)
      )
    );
  }
}