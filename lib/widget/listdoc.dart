import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/screen/previewscreen.dart';

class ListDoc extends StatefulWidget {
  const ListDoc({Key? key, required this.activity, required this.index}) : super(key: key);

  final int index;
  final List activity;

  @override
  State<ListDoc> createState() => _ListDocState();
}

class _ListDocState extends State<ListDoc> {
  trimUrl (String trim) {
    // for( var i = 0 ; i < activity.length; i++){
    //   var trim = activity[i]['url'];
    // }
    if (trim.contains('https://')) {
      if (trim.contains('www.tradewheel.com')) {
        return trim.toString().substring(27);
      } else {
        return trim.toString().substring(8);
      }
    }else if (trim.contains('http://')) {
    return trim.toString().substring(7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        onTap: () {
          if (widget.activity[widget.index]['status'] == "SUCCESS") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PreviewScreen(
                    url: widget.activity[widget.index]["result"]
                  );
                }
              )
            );
          } else {
            // loading
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10)
                    ),
                    backgroundColor: const Color.fromARGB(255, 224, 232, 235),
                    title: (widget.activity[widget.index]['status'] == "LOADING") 
                      ? const Text('Your request is in queue') 
                      : const Text('URL Invalid'),
                    content: (widget.activity[widget.index]['status'] == "LOADING") 
                      ? const Text('Please Wait') 
                      : const Text('Try using another URL'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                            color: Color.fromARGB(255, 23, 22, 29)
                          ),
                        )
                      )
                    ],
                  );
                }
            );
          }
        },
        child: Padding(
          padding:const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trimUrl(widget.activity[widget.index]["url"]),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          DateFormat.yMMMd().format(
                            DateTime.parse(
                              widget.activity[widget.index]["createdAt"]
                            )
                          ),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 10
                          )
                        ),
                        // Text(activity[index]["createdAt"])
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600
                        )
                      ),
                      const SizedBox(height: 5),
                      // if(activity[index]['status'] == "SUCCESS"){
                      //   Icon(Icons.done)
                      // }
                      if (widget.activity[widget.index]['status'] == "SUCCESS") ...[
                        const Icon(Icons.done, color: Colors.green)
                      ] else if (widget.activity[widget.index]['status'] == "LOADING") ...[
                        const CupertinoActivityIndicator()
                      ] else ...[
                        const Icon(Icons.clear,color: Colors.red)
                      ]
                    ],
                  )
                ],
              ),
              if (widget.activity[widget.index]['status'] == 'SUCCESS')...[
                if (widget.activity[widget.index]['url'].toString().contains('tradewheel') ||widget.activity[widget.index]['url'].toString().contains('go4worldbusiness') )...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: FadeInImage(
                      image: NetworkImage(widget.activity[widget.index]['result']),
                      placeholder: const AssetImage('./images/folder.png'),
                    )
                  )
                ]

              ]
            ],
          ),
        ),
      )
    );
  }
}