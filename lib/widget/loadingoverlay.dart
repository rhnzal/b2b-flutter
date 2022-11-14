import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 224, 232, 235),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        padding: const EdgeInsets.all(20),
        child: const CircularProgressIndicator(
          color: Color.fromARGB(255, 23, 22, 29),
        )
      ),
    );
  }
}