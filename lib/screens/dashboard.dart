import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/account/account_page.dart';
import 'package:instagram_clone/screens/globe_screen.dart';
import '../../screens/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;

  final pages = [
    MyHomePage(),
    GlobeScreen(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.camera,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
            color: Colors.white,
          ),
        ],
        title: SizedBox(
          height: 35.0,
          child: Image.asset(
            "assets/images/insta_logo.png",
            color: Colors.white,
          ),
        ),
        // title: Text(
        //   "Instagram",
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      ),
      backgroundColor: Colors.black,
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.purpleAccent,
                    size: 20,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    CupertinoIcons.globe,
                    color: Colors.purpleAccent,
                    size: 20,
                  )
                : const Icon(
                    CupertinoIcons.globe,
                    color: Colors.white,
                    size: 20,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person,
                    color: Colors.purpleAccent,
                    size: 20,
                  )
                : const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
          ),
          // IconButton(
          //   enableFeedback: false,
          //   onPressed: () {
          //     setState(() {
          //       pageIndex = 3;
          //     });
          //   },
          //   icon: pageIndex == 3
          //       ? const Icon(
          //           Icons.person,
          //           color: Colors.white,
          //           size: 35,
          //         )
          //       : const Icon(
          //           Icons.person_outline,
          //           color: Colors.white,
          //           size: 35,
          //         ),
          // ),
        ],
      ),
    );
  }
}
