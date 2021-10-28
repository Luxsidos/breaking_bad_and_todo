import 'dart:convert';
import 'dart:math';
import 'package:braking_bad_todo/models/characters.dart';
import 'package:braking_bad_todo/models/starIcons.dart';
import 'package:braking_bad_todo/ui/screens/detailsPage/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class BodyMenu extends StatefulWidget {
  BodyMenu({Key? key}) : super(key: key);

  @override
  _BodyMenuState createState() => _BodyMenuState();
}

class _BodyMenuState extends State<BodyMenu> with TickerProviderStateMixin {
  List<Character> characterList = [];
  int dataLength = 0;
  int randomImgAndName = 0;
  Future characterniOlibKel() async {
    Response response =
        await get(Uri.parse("https://www.breakingbadapi.com/api/characters"));
    var data = jsonDecode(response.body);

    setState(() {
      for (int i = 0; i < data.length; i++) {
        Character k = Character();
        k.id = data[i]["char_id"];
        k.name = data[i]["name"];
        k.img = data[i]["img"];
        k.birthday = data[i]["birthday"];
        k.portrayed = data[i]["portrayed"];
        k.nickname = data[i]["nickname"];
        characterList.add(k);
      }
      dataLength = data.length;
      randomImgAndName = Random().nextInt(dataLength);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    characterniOlibKel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: characterList.length != 0
          ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.black.withOpacity(0.06),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.0)),
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.black54,
                        ),
                        hintText: "Search your loacation",
                        hintStyle: TextStyle(fontSize: 14.0)),
                  ),
                  SizedBox(height: 16.0),
                  //Spacer(),
                  Expanded(
                    child: Container(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.2 / 2,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemBuilder: (oontext, index) {
                          return Container(
                            margin: EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      hero: characterList[index].name,
                                      id: characterList[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: characterList[index].name!,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: NetworkImage(
                                                  characterList[index]
                                                      .img
                                                      .toString()),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(16.0),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text(
                                      characterList[index].name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                  Text(
                                    characterList[index].nickname.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.0,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: dataLength,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Death of day',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    height: 100.0,
                    margin: EdgeInsets.only(bottom: 16.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 6.0,
                              color: Colors.black12,
                              offset: Offset(2.0, 2.0))
                        ]),
                    child: Row(
                      children: [
                        Container(
                          
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.topCenter,
                                image: NetworkImage(
                                    characterList[randomImgAndName]
                                        .img
                                        .toString()),
                                fit: BoxFit.cover),
                            color: Color.fromARGB(245, 245, 245, 250),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          width: 74.0,
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(),
                                flex: 20,
                              ),
                              Expanded(
                                child: Text(
                                  characterList[randomImgAndName].name!,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                flex: 20,
                              ),
                              Expanded(
                                child: Text(
                                  characterList[randomImgAndName].birthday!,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                flex: 28,
                              ),
                              Expanded(
                                child: Row(
                                  children: StarIcons.starIcon(),
                                ),
                                flex: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          )
          : Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent.shade100,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            ),
    );
  }
}
