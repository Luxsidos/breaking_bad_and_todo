import 'dart:convert';

import 'package:braking_bad_todo/ui/chat/commentPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String? hero;
  int? id;
  DetailPage({Key? key, this.id, this.hero}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  TabController? _tabController;
  var characterData;
  //API

  characterniOlibKel() async {
    Response data = await get(Uri.parse(
        "https://www.breakingbadapi.com/api/characters/${widget.id}"));

    setState(() {
      characterData = jsonDecode(data.body);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    characterniOlibKel();
  }

  @override
  Widget build(BuildContext context) {
    return characterData != null
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              toolbarHeight: 70.0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon:
                    Icon(CupertinoIcons.back, color: Colors.black, size: 28.0),
              ),
              actions: [
                Container(
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(
                            id: widget.id,
                            name: characterData[0]['name'],
                          ),
                        ),
                      );
                    },
                    child: Icon(CupertinoIcons.chat_bubble,
                        color: Colors.black, size: 20.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Icon(CupertinoIcons.search,
                        color: Colors.black, size: 20.0),
                  ),
                ),
                SizedBox(width: 24.0),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(characterData[0]['img']),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0)
                    ],
                    begin: Alignment.bottomRight,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              characterData[0]['name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: kPadding / 2),
                            Text(
                              characterData[0]['nickname'],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: kPadding / 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.star_sharp,
                                    color: Colors.orange, size: 15.0),
                                Icon(Icons.star_sharp,
                                    color: Colors.orange, size: 15.0),
                                Icon(Icons.star_sharp,
                                    color: Colors.orange, size: 15.0),
                                Icon(Icons.star_sharp,
                                    color: Colors.orange, size: 15.0),
                                Icon(Icons.star_sharp,
                                    color: Colors.orange, size: 15.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kPadding),
                      Container(
                        height: 600.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          color: Colors.orange,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 28.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(characterData[0]['birthday']),
                                  Text("+18"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 28.0, horizontal: 32.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    TabBar(
                                      indicatorColor: Colors.orange,
                                      indicatorWeight: 2.5,
                                      labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelColor: Colors.black,
                                      controller: _tabController,
                                      tabs: [
                                        Tab(
                                          text: "Overview",
                                        ),
                                        Tab(
                                          text: "Gallery",
                                        ),
                                        Tab(
                                          text: "Reviews",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          ),
                                          Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          ),
                                          Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        : Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent.shade100,
                controller: AnimationController(
                  vsync: this,
                  duration: const Duration(milliseconds: 1200),
                ),
              ),
            ),
          );
  }
}
