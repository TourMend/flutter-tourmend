import 'package:flutter/material.dart';
import 'package:flutter_app/modals/commentModal/comments.dart';

class CommentCard extends StatefulWidget {
  final List<CommentsData> commentsData;
  final int index;

  CommentCard({
    this.commentsData,
    this.index,
  });

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width - 100,
      child: Card(
        color: Colors.blue,
        child: Center(
          child: Text('${widget.commentsData[widget.index].comment}'),
        ),
      ),
    );
  }
}
