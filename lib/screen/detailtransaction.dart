import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:webview_flutter/webview_flutter.dart';

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
  bool status = false;
  String price = '';
  String date = '';

  @override
  void initState(){
    super.initState();
    getActivity();
    // print(widget.index);
  }

  Future<void> getActivity() async{
    var response = await http_test.get(url: urlHistory);
    data = response.data;
    if (response.isSuccess){
      data = response.data;
      orderId = data[widget.index]['orderId'].toString();
      product = data[widget.index]['product']['title'].toString();
      status = data[widget.index]['isPaid'];

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
            status.toString(),
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

    Widget payButton = Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
        // alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 23, 22, 29), shape: const StadiumBorder()),
            onPressed:() async {
              var count = 0;
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                    return Scaffold(
                      appBar: AppBar(
                        leading: BackButton(
                          onPressed: (){
                            Navigator.popUntil(context, ((route) {
                              return count++ == 2;
                            }));
                          },
                        ),
                        backgroundColor: const Color.fromARGB(255, 23, 22, 29),
                        automaticallyImplyLeading: false,
                      ),
                      body: const WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: 'https://checkout-staging.xendit.co/web/6322943cd0a17dc369f34252',
                      ),
                    );
                  })));
            },
            child: const SizedBox(
                width: 100,
                child: Text(
                  'Pay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 224, 232, 235)),
                ))),
          ),
      )); 

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
      :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          card,
          detail,
          if(!status)...[payButton]
        ],
      ),
    );
  }
}