import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/services/commentServices/fetchComments.dart';
import '../modals/commentModal/comments.dart';
import '../widgets/jsonListViewWidget/jsonListView.dart';
import '../widgets/commentWidgets/commentCard.dart';

class CommentPage extends StatefulWidget {
  final String newsId;

  CommentPage({
    Key key,
    @required this.newsId,
  }) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<CommentsData> commentsData = List();
  ScrollController _scrollController;
  int pageNumber;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    pageNumber = 1;
    isLoading = true;

    _fetchComments().then((result) {
      if (result != null) {
        for (var place in result) {
          commentsData.add(place);
          setState(() {
            isLoading = false;
          });
        }
      } else
        setState(() {
          isLoading = false;
        });
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
        _fetchComments().then((result) {
          if (result != null) {
            for (var place in result) {
              commentsData.add(place);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<CommentsData>>(
          initialData: commentsData,
          future: _fetchComments(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return JsonListView(
              snapshot: snapshot,
              listData: commentsData,
              scrollController: _scrollController,
              childWidget: (value) => CommentCard(
                commentsData: commentsData,
                index: value,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<CommentsData>> _fetchComments() {
    return FetchComments.fetchComments(
            pageNumber: pageNumber, newsId: widget.newsId)
        .then((value) => value.comments);
  }
}
