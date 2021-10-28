import 'package:braking_bad_todo/ui/chat/componentes/bodyComment.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  int? id;
  String? name;
  CommentPage({Key? key, this.id, this.name}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Comment Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BodyComment(id: widget.id, name: widget.name,),
    );
  }
}
