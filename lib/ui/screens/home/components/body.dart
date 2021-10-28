import 'package:braking_bad_todo/ui/screens/detailsPage/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: kPadding),
      child: Column(
        children: [
          // SEARCH SECTION
          Container(
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Search your location',
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(height: kPadding),
          // PICTURES SECTION
          Container(
            height: size.height * 0.5,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2 / 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 25,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(hero: "pic$index",),
                      ),
                    );
                  },
                  child: HeroMode(
                    enabled: true,
                    child: Hero(
                      tag: "pic$index",
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/winter.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Resorts",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              "650+ Resorts",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: kPadding * 2),
          // FEATURED SECTION TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    "View all",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 13.0,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: kPadding),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(kPadding - 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/mountain.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: kPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Arabian Resort",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                "\$250",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(
                            "Ai Thumamah, Riyadh",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Row(
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
