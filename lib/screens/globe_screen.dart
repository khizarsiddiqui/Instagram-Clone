// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controllers/globe_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tuple/tuple.dart';
import 'package:masonry_list_view_grid/masonry_list_view_grid.dart';

import '../models/globe_model.dart';

class GlobeScreen extends StatefulWidget {
  @override
  _GlobeScreenState createState() => _GlobeScreenState();
}

class _GlobeScreenState extends State<GlobeScreen> {
  final GlobeController globeController = Get.put(GlobeController());
  final Rx<GlobeModel> globeModel = GlobeModel().obs;
  final RxBool isLoading = false.obs;
  List<Tuple2<IconData, String>> categories = [
    Tuple2(Icons.shop, 'Shop'),
    Tuple2(Icons.food_bank, 'Food'),
    Tuple2(Icons.style, 'Style'),
    Tuple2(Icons.airplanemode_active, 'Travel'),
    Tuple2(Icons.brush, 'Art'),
    Tuple2(Icons.music_note, 'Music'),
  ];
  Future<void> loadGetxData() async {
    await getRequest();
    setArgs();
  }

  Future<void> getRequest() async {
    globeController.fetchFeeds();
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
  // List<String> imagePaths = [
  //   'assets/images/image1.jpg',
  //   'assets/images/image2.jpg',
  //   'assets/images/image3.jpg',
  //   'assets/images/image4.jpg',
  //   'assets/images/image5.jpg',
  //   // 'assets/image6.jpg',
  //   // 'assets/image7.jpg',
  //   // 'assets/image8.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    // Shuffle the image paths
    // imagePaths.shuffle(Random());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.search,
          color: Colors.white,
        ),
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.leak_add,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        bottom: PreferredSize(
            child: Container(
              height: 48,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  width: 16,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Text(
                  categories[index].item2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                itemCount: categories.length,
              ),
            ),
            preferredSize: Size.fromHeight(48)),
      ),
      body: Expanded(
        child: Obx(
          () {
            if (globeController.isLoading.value) {
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
              var data = globeController.globeModel;
              var list = data;
              return MasonryListViewGrid(
                column: 2,
                padding: const EdgeInsets.all(8.0),
                children: List.generate(
                  list.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    height: (200 + (index % 3 == 0 ? 50 : 0)).toDouble(),
                    child: Center(
                      child: Image.network(list[index].image ?? "No Data"),
                    ),
                  ),
                ),
              );
              // return MasonryGridView.builder(
              //   itemCount: list.length,
              //   // crossAxisCount: 4,
              //   mainAxisSpacing: 4,
              //   crossAxisSpacing: 4,
              //   itemBuilder: (context, index) {
              //     return Image.network(
              //       list[index].image ?? "No Data",
              //     );
              //   },
              //   gridDelegate: ,
              // );
              // return GridView.builder(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
              //   itemCount: list.length,
              //   itemBuilder: (context, index) {
              //     var item = list[index].image;
              //     return InkResponse(
              //       child: Image.network(
              //         item ?? "No Data",
              //         fit: BoxFit.cover,
              //       ),
              //       onTap: () {
              //         // Navigator.of(context).push(
              //         //   MaterialPageRoute(
              //         //     builder: (context) => GlobeScreen(),
              //         //   ),
              //         // );
              //       },
              //     );
              //   },
              // );
            }
          },
        ),
      ),
    );
  }
}
