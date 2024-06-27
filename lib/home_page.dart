// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/home_model.dart';
import 'dart:typed_data';
import 'controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Uint8List> _fetchImage() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/icon/abc123/150'));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  final HomeController homeController = Get.put(HomeController());
  final Rx<HomeModel> homeModel = HomeModel().obs;
  final RxBool isLoading = false.obs;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> loadGetxData() async {
    await getRequest();
    setArgs();
  }

  Future<void> getRequest() async {
    homeController.fetchPosts();
  }

  @override
  void initState() {
    super.initState();
    loadGetxData();
    setArgs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setArgs() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80.0,
                // color: Colors.red,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(6.0),
                      child: StoryCircle(),
                    );
                  },
                ),
              ),
              Container(
                height: 530.0,
                child: Obx(() {
                  if (homeController.isLoading.value) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CircularProgressIndicator();
                        });
                  } else {
                    var data = homeController.homeModel.value;
                    var list = data.posts;
                    return ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        // itemCount: list?.length,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          var item = list?[index];
                          return Column(
                            children: [
                              Divider(),
                              Row(
                                children: [
                                  StoryCircle(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      item!.title.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              ExpandableText(
                                text: item.body.toString(),
                              ),
                              Divider(),
                              FutureBuilder<Uint8List>(
                                future: _fetchImage(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Image.memory(snapshot.data!);
                                  }
                                },
                              ),
                              Divider(),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 24.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: item.tags?.length,
                                  itemBuilder: (context, index) {
                                    var tag = item.tags?[index];
                                    return Text(
                                      "# $tag ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    item.reactions!.likes.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.thumb_down_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    item.reactions!.dislikes.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    item.views.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    item.userId.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          );
                        });
                  }
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
                // color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.business,
                // color: Colors.white,
              ),
              label: 'Globe',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
                // color: Colors.white,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class StoryCircle extends StatelessWidget {
  const StoryCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purpleAccent,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40.0,
        child: Icon(
          Icons.person,
          size: 40.0,
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText({required this.text, this.maxLines = 3});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate if text exceeds the maxLines limit
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text),
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final exceedsMaxLines = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              maxLines: _expanded ? null : widget.maxLines,
              overflow:
                  _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (exceedsMaxLines)
              GestureDetector(
                onTap: _toggleExpanded,
                child: Text(
                  _expanded ? 'See Less' : 'See More',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
