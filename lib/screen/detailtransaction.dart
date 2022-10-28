import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/http.dart' as http_test;

class DetailTransaction extends StatefulWidget {
  const DetailTransaction({Key? key, required this.index}) : super(key: key);

  final int index;
  
  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  bool isLoad = true;
  List data = [];
  String orderId = '';
  String product = '';
  String status = '';
  String price = '';
  String date = '';

  @override
  void initState(){
    super.initState();
    getActivity();
    print(widget.index);
  }

  getActivity() async{
    var response = await http_test.get(url: urlHistory);
    data = response.data;
    if (response.isSuccess){
      data = response.data;
      orderId = data[widget.index]['orderId'].toString();
      product = data[widget.index]['product']['title'].toString();
      status = data[widget.index]['isPaid'].toString();

      price = NumberFormat.simpleCurrency(locale:'in', decimalDigits: 0).format(data[widget.index]['product']['price']);
      date = DateFormat.yMMMd().format(DateTime.parse(data[widget.index]["createdAt"]));
      setState(() {
        isLoad = false;
      });
    }else{
      var error = response.message;
      if(mounted){
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor:const Color.fromARGB(255, 224, 232, 235),
                  title: const Text('Error'),
                  titleTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 23, 22, 29),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600),
                  content: Text('$error'),
                  contentTextStyle: const TextStyle(color: Color.fromARGB(255, 23, 22, 29)),
                  actions: [
                    TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.transparent),
                            minimumSize: MaterialStateProperty.all(
                                Size.zero),
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 10, 10))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Color.fromARGB(255, 23, 22, 29),),
                        )),
                  ],
                )));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card =Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding:const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // getUrl().toString(),
                      product,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        // 'Tanggal',
                      date,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 10)),
                    // Text(activity[index]["createdAt"])
                  ],
                ),
              ),
              Text(
                      // getUrl().toString(),
                      price,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          ),
        )
      )
    );

    Widget detail = Container(
      margin: const EdgeInsets.fromLTRB(30, 5, 30, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //order date
          const Text(
            'Order Date',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //order id
          const Text(
            'Order ID',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            orderId,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //product title
          const Text(
            'Product',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //status
          const Text(
            'Status',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            status,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // price
          const Text(
            'Price',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            price,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 22, 29),
        centerTitle: true,
        title: const Text(
          'Transaction Detail',
          style: TextStyle(
            color: Color.fromARGB(255, 224, 232, 235)
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: isLoad ? const Center(
        child: CircularProgressIndicator(color: Color.fromARGB(255, 23, 22, 29),),
      )
      :ListView(
        children: [
          card,
          detail
        ],
      ),
    );
  }
}