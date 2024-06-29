// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, unused_element, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controllers/image_controller.dart';
import 'package:instagram_clone/models/home_model.dart';
import '../controllers/home_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../models/image_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeController homeController = Get.put(HomeController());
  final Rx<HomeModel> homeModel = HomeModel().obs;
  final ImageController imageController = Get.put(ImageController());
  final Rx<ImageModel> imageModel = ImageModel().obs;
  final RxBool isLoading = false.obs;
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  Future<void> loadGetxData() async {
    await getRequest();
    setArgs();
  }

  Future<void> getRequest() async {
    homeController.fetchPosts();
    imageController.fetchImages();
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
                // height: 530.0,
                child: Expanded(
                  child: Obx(() {
                    if (homeController.isLoading.value) {
                      return Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.purpleAccent,
                          size: 50,
                        ),
                      );
                      // return ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     scrollDirection: Axis.vertical,
                      //     itemCount: 1,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return CircularProgressIndicator();
                      //     });
                    } else {
                      var data = homeController.homeModel.value;
                      var data_image = imageController.imageModel;
                      var list = data.posts;
                      var list_image = data_image.value;
                      return ListView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          // itemCount: list?.length,
                          itemCount: list_image.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = list?[index];
                            var item_image = list_image[index];
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
                                CachedNetworkImage(
                                  imageUrl: item_image.image ?? "---",
                                  placeholder: (context, url) => Center(
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                      color: Colors.purpleAccent,
                                      size: 50,
                                    ),
                                  ),
                                  // errorWidget: (context, url, error) =>
                                  //     Icon(Icons.error),
                                  fadeInDuration: const Duration(seconds: 3),
                                  width: 250,
                                  fit: BoxFit.cover,
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
              ),
            ],
          ),
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
      padding: EdgeInsets.all(3),
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
