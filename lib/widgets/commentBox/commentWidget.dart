import 'dart:ui';

import "package:flutter/material.dart";

class CommentWidget extends StatefulWidget {
  final ValueChanged<String> onValueChanged, onSubmit;
  final VoidCallback onTap;
  final TextEditingController commentController;
  final bool canComment;

  CommentWidget({
    @required this.onValueChanged,
    @required this.onSubmit,
    @required this.onTap,
    @required this.commentController,
    @required this.canComment,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20.0, bottom: 15.0, right: 10.0),
                width: MediaQuery.of(context).size.width - 100,
                child: TextField(
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.bottom,
                  textInputAction: TextInputAction.send,
                  controller: widget.commentController,
                  onChanged: (value) {
                    widget.onValueChanged(value);
                  },
                  onSubmitted: (value) {
                    widget.onSubmit(value);
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 10.0,
                        bottom: 13.0,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Add a Comment',
                      hintStyle: TextStyle(fontSize: 19.0)),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: widget.canComment ? () => widget.onTap() : () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Icon(
                        Icons.send,
                        color: widget.canComment ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Icon(
                        Icons.share,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 188,
            child: SizedBox.expand(
                child: Column(
              children: <Widget>[
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 20.0, top: 10.0, bottom: 10.0),
                          child: ClipOval(
                            child: Material(
                              // button color
                              child: InkWell(
                                child: SizedBox(
                                    width: 56,
                                    height: 56, // inkwell color
                                    child: Image.asset(
                                        'assets/social_media/facebook.png')),
                                onTap: () {},
                              ),
                            ),
                          )),
                      Container(
                          child: Text(
                        "Facebook",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          decoration: TextDecoration.none,
                        ),
                      ))
                      // inkwell color
                    ]),
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ClipOval(
                            child: Material(
                              // button color
                              child: InkWell(
                                child: SizedBox(
                                    width: 56,
                                    height: 56,
                                    child: Image.asset(
                                        'assets/social_media/twitter.png')),
                                onTap: () {},
                              ),
                            ),
                          )),
                      Container(
                          child: Text(
                        "Twitter",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.normal),
                      ))
                    ])
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 40.0, right: 10.0, top: 10.0, bottom: 10.0),
                        child: ButtonTheme(
                            height: 35.0,
                            minWidth: MediaQuery.of(context).size.width - 100,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              splashColor: Colors.black.withAlpha(40),
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop(false);
                                });
                              },
                            ))),
                  ],
                ))
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
