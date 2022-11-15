import 'package:flutter/material.dart';

class MengDialog extends StatelessWidget {
  const MengDialog({Key? key, required this.title, required this.content, required this.buttons}) : super(key: key);

  final String title;
  final String content;
  final List<MengDialogButton> buttons;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      backgroundColor:const Color.fromARGB(255, 224, 232, 235),
      
      // title
      title: Text(title),
      titleTextStyle: const TextStyle(
        color: Color.fromARGB(255, 23, 22, 29),
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 20
      ),
      
      // content
      content: Text(content),
      contentTextStyle: const TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
      
      // action
      actions: buttons.map(
        (button) {
          return TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              minimumSize: MaterialStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(0, 0, 10, 10)
              )
            ),

            onPressed: button.onPressed,

            child: Text(
              button.text,
              style: const TextStyle(color: Color.fromARGB(255, 23, 22, 29),),
            )
          );
        }
      ).toList()
    );
  }
}

class MengDialogButton {
  MengDialogButton(
    {
      required this.text, 
      required this.onPressed
    }
  );

  final String text;
  final void Function() onPressed;
}