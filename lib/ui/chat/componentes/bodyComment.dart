import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BodyComment extends StatefulWidget {
  int? id;
  String? name;
  BodyComment({Key? key, this.id, this.name}) : super(key: key);

  @override
  _BodyCommentState createState() => _BodyCommentState();
}

class _BodyCommentState extends State<BodyComment>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<dynamic> commentList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // DBGA MALUMOT YOZ
  void dbSet(text) async {
    await _firestore.collection('characters').doc(widget.id.toString()).set({
      "comments": FieldValue.arrayUnion([text])
    }, SetOptions(merge: true));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbGet();
  }

  // DBDAN MALUMOT OL
  void dbGet() async {
    var comments = await _firestore.collection('characters').get();
    for (var comment in comments.docs) {
      if (comment.id == widget.id.toString()) {
        commentList = comment['comments'];
      }
    }
    setState(() {});
  }

  void removeFromList(String cmt) async {
    commentList.remove(cmt);
    await _firestore
        .collection('characters')
        .doc(widget.id.toString())
        .set({"comments": commentList});

    setState(() {});
  }

  Widget commentChild() {
    return commentList.length != 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Comment Clicked")));
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(50))),
                      child: CircleAvatar(
                        radius: 50,
                        child: Text(commentList[index][0]),
                      ),
                    ),
                  ),
                  title: Text(
                    commentList[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(commentList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      print("Bosildi: ${commentList[index]}");
                      removeFromList(commentList[index]);
                    },
                  ),
                ),
              );
            },
            itemCount: commentList.length,
          )
        : Center(
            child: OutlinedButton(
              child: Text(
                "SAY 'GOOD' IF YOU CAN !!!",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                dbSet('GOOD');
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommentBox(
        userImage:
            "https://avatars.mds.yandex.net/get-zen_doc/1899873/pub_5dcdb90634bb04739962fe7b_5dd29488e5968126aa191e1a/scale_1200",
        child: commentChild(),
        labelText: 'Write a comment...',
        withBorder: false,
        errorText: 'Comment cannot be blank',
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              var value = commentController.text;
              commentList.insert(0, value);
            });
            dbSet(commentController.text);
            commentController.clear();
            FocusScope.of(context).unfocus();
          } else {
            print("Not validated");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        sendWidget: Icon(Icons.send_sharp, size: 28, color: Colors.white),
      ),
    );
  }
}
