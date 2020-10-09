import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/commentServices/addComment.dart';
import '../../modals/newsModal/news.dart';
import '../commentBox/commentWidget.dart';

class DetailNews extends StatefulWidget {
  final NewsData newsData;
  final String userEmail;
  DetailNews({
    Key key,
    @required this.newsData,
    @required this.userEmail,
  }) : super(key: key);
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> with TickerProviderStateMixin {
  TextEditingController _commentController;
  bool _canComment;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _commentController = TextEditingController();
    _canComment = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Center(
              child: Text(
            'News',
            style: TextStyle(
              letterSpacing: 8.0,
              shadows: [
                Shadow(color: Colors.grey[300], offset: Offset(10.0, 5.0))
              ],
              fontSize: 30.0,
              fontFamily: 'BioRhyme',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )),
        ),
        actions: <Widget>[
          FlatButton(
            child: Row(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Text(
                  "150",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 3.0),
                  child: Icon(
                    Icons.mode_comment,
                    size: 19,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            onPressed: () {
              // show all comments only
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      widget.newsData.headLine,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    child: Stack(children: <Widget>[
                      Image.network(
                        'http://10.0.2.2/TourMendWebServices/Images/news/${widget.newsData.image}',
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ]),
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      widget.newsData.des,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommentWidget(
            commentController: _commentController,
            canComment: _canComment,
            onValueChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _canComment = true;
                });
              } else {
                setState(() {
                  _canComment = false;
                });
              }
            },
            onSubmit: (value) {
              if (value.isEmpty) {
                setState(() {
                  _canComment = false;
                });
                return;
              }
              _addComment(comment: value);
            },
            onTap: () => _addComment(comment: _commentController.text),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _addComment({String comment}) async {
    AddComments.addComment(comment, widget.userEmail, widget.newsData.id)
        .then((result) {
      print(result);
      if (result == '1') {
        _showSnackBar(context, 'Comment added!');
      } else if (result == '0') {
        _showSnackBar(context, 'Error while adding comment!');
      } else if (result == '2') {
        _showSnackBar(context, 'Email while fetching user id!');
      } else if (result == '3') {
        _showSnackBar(context, 'Error in method!');
      }
    });
  }
}
