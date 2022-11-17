import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/screen/detailtransaction.dart';
import 'package:projectb2b/screen/paymentscreen.dart';
import 'package:projectb2b/widget/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:projectb2b/widget/indicator.dart';

class QuotaScreen extends StatefulWidget {
  const QuotaScreen({Key? key}) : super(key: key);

  @override
  State<QuotaScreen> createState() => _QuotaScreenState();
}

class _QuotaScreenState extends State<QuotaScreen> {
  late SharedPreferences prefs;
  String? pfp;
  String? displayName = '';
  String quota = '';
  String subs = '';
  var list = [];
  bool isLoad = true;

  @override
  void initState(){
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    pfp = prefs.getString('pfp');
    // getActivity();
    setState(() {});
    getQuota();
    getHistory();
  }

  getQuota() async {
    var response = await http_test.get(url: urlQuota);
    quota = response.data['quota'].toString();
    subs = response.data['subs'].toString();
    if(mounted){
      setState(() {});
    }
  }

  getHistory() async {
    var response = await http_test.get(url: urlHistory);
    if (response.isSuccess) {
      list = response.data;
      if(mounted){
        setState(() {
          isLoad = false;
        });
      }
    }else{
      var error = response.message;
      if(mounted){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor:const Color.fromARGB(255, 224, 232, 235),
            title: const Text('Error'),
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600
            ),
            content: Text('$error'),
            contentTextStyle: const TextStyle(
              color: Color.fromARGB(255, 23, 22, 29)
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  tapTargetSize:MaterialTapTargetSize.shrinkWrap,
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(0, 0, 10, 10)
                  )
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Color.fromARGB(255, 23, 22, 29)
                  ),
                )
              ),
            ],
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark;
    Widget wishlist = Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox( width: 5,),
          Text(
            'Transaction History',
            style: TextStyle(
              fontFamily: 'Inter', 
              fontWeight: FontWeight.w800, 
              fontSize: 12
            ),
          )
        ],
      ),
    );

    Widget favoriteList =  Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding:const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Your Subscription : '),
                  //nama paket
                  Text(
                    subs,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 224, 232, 235),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remaining Quota :',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 10
                          )
                        ),
                        const SizedBox(height: 5),
                        Text(
                          quota,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onSurface: const Color.fromARGB(255, 255, 255, 255),
                      primary: const Color.fromARGB(255, 217, 217, 217),
                      shape: const StadiumBorder(),
                      elevation: 10
                    ),
                    onPressed: (){
                      // push quota product screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return const PaymentScreen();
                          },
                        )
                      ).then (              // then refresh the list and quota when pop to this screen
                        (value) {
                          setState(() {
                            getQuota();
                            getHistory();
                          });
                        }
                      );
                    }, 
                    child: const Text(
                      'Add', 
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 27, 26, 32),
                        fontSize: 12
                      )
                    )
                  )
                ],
              ),
            ],
          ),
        )
      )
    );

    Widget transactionList= isLoad ? const Loading(pad: 70)
      : list.isEmpty ? const Empty(pad: 70)
      : Expanded(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.white,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailTransaction(index: index);
                            }
                          )
                        );
                      },
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
                                    list[index]['product']['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(DateTime.parse(list[index]["createdAt"])),
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10
                                    )
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              NumberFormat.simpleCurrency(locale:'in', decimalDigits: 0).format(list[index]['product']['price']),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                              ),
                            ),
                            const Icon(Icons.navigate_next_outlined)
                          ],
                        ),
                      ),
                    )
                  )
                )
              ),
            ),
          ),
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 224, 232, 235),
      body: AnnotatedRegion(
        value: _currentStyle,
        child: Column(
          children: [
            WelcomeUser(),
            favoriteList, 
            wishlist, 
            transactionList
          ],
        ),
      ),
    );
  }
}