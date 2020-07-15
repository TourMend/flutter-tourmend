import 'package:flutter/material.dart';

class JsonListView extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final ScrollController scrollController;

  JsonListView({this.snapshot, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        itemCount: snapshot.data.length,
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        itemBuilder: (context, index) {
          return ListView(
            children: snapshot.data[index]
                .map<Widget>((data) => Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      child: Column(children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              // var route = new MaterialPageRoute(
                              //   builder: (BuildContext context) =>
                              //       new NestedTabBar(value: data),
                              // );

                              // Navigator.of(context).push(route);
                            },
                            child: new Container(
                              padding: EdgeInsets.all(3.0),
                              margin: EdgeInsets.all(3.0),
                              child: Column(children: <Widget>[
                                Padding(
                                  child: Image.network(
                                    data.placesImageURL,
                                    fit: BoxFit.cover,
                                  ),
                                  padding: EdgeInsets.only(bottom: 2.0),
                                ),
                                Row(children: <Widget>[
                                  Padding(
                                      child: Text(
                                        data.placeName,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        textAlign: TextAlign.right,
                                      ),
                                      padding: EdgeInsets.all(1.0)),
                                  Text(" | "),
                                  Padding(
                                      child: Text(
                                        data.destination,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.right,
                                      ),
                                      padding: EdgeInsets.all(1.0)),
                                ]),
                                Divider(color: Colors.black),
                              ]),
                            ))
                      ]),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
