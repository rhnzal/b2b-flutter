import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences prefs;
  String? displayName = '';

  @override
  void initState(){
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('name');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeUser = Container(
    margin: const EdgeInsets.fromLTRB(20, 40, 10, 5),
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('images/user.png'),
          radius: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome,',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 10)),
              Text(
                '$displayName',
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              )
            ],
          ),
        )
      ],
    ),
  );

  Widget wishlist = Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 10, 0),
      child: Row(
        children: const [
          Icon(Icons.list_rounded),
          SizedBox( width: 5,),
          Text('Wishlist',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w800, fontSize: 12),
          )
        ],
      ),
    );

  Widget favoriteList =  Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Card(
      elevation: 10,
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
                    'Judul',
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      'Tanggal',
                    // DateFormat.yMMMd().format(DateTime.parse(activity[index]["createdAt"])),
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 10)),
                  // Text(activity[index]["createdAt"])
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    onSurface: const Color.fromARGB(255, 255, 255, 255),
                    primary: const Color.fromARGB(255, 217, 217, 217),
                    shape: const StadiumBorder(),
                    elevation: 10),
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: ((context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    backgroundColor: Color.fromARGB(255, 224, 232, 235),
                    title: Text('Open this URL ?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromARGB(255, 26, 25, 32))),
                    content: Container(
                      height: 35,
                      child: Text('URL')
                      ),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 10, 10))),
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text('Cancel',
                        style: TextStyle(
                                      color: Color.fromARGB(255, 23, 22, 29)))),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 0, 20, 10))),
                        onPressed: (){}, 
                        child: Text('Ok',
                        style: TextStyle(
                                      color: Color.fromARGB(255, 23, 22, 29))))
                    ],
                  )));
              }, 
              child: Text('Open', 
              style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 27, 26, 32),
                        fontSize: 12)))
          ],
        ),
      )
    )
  );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 232, 235),
      body: Column(
        children: [welcomeUser, wishlist, favoriteList],
      ),
    );
  }
}
