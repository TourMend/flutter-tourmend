import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../widgets/placesWidgets/nestedTabBar.dart';
import '../services/fetchPlaces.dart';
import '../modals/places.dart';

import '../widgets/placesWidgets/searchPage.dart';

class PlacesPage extends StatefulWidget {
  final String title;

  PlacesPage({Key key, this.title}) : super(key: key);
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  TextEditingController _search;
  List<PlacesData> placesData = List();
  ScrollController _scrollController;
  int pageNumber;
  bool isLoading, canSearch;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _search = TextEditingController();
    pageNumber = 1;
    isLoading = true;
    canSearch = false;
    _fetchPlaces().then((result) {
      for (var place in result) {
        placesData.add(place);
        setState(() {
          isLoading = false;
        });
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
        _fetchPlaces().then((result) {
          if (result != null) {
            for (var place in result) {
              placesData.add(place);
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 9.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(0.0, 40.0),
                    blurRadius: 40.0,
                  )
                ],
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 0.75),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            canSearch = true;
                          });
                        } else {
                          setState(() {
                            canSearch = false;
                          });
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            canSearch = false;
                          });
                          return;
                        }
                        _goToSearch(value);
                      },
                      style: TextStyle(height: 1.3),
                      controller: _search,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(left: 20.0, bottom: 11.0),
                        hintText: "Search here",
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  canSearch
                      ? InkWell(
                          onTap: () {
                            _goToSearch(_search.text);
                          },
                          child: CircleAvatar(
                              radius: 17.5,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.search,
                                size: 24.0,
                              )),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<PlacesData>>(
          initialData: placesData,
          future: _fetchPlaces(),
          builder: (context, snapshot) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: placesData.length,
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (snapshot.data != null) {
                  if (snapshot.data.length + 1 == index) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NestedTabBar(
                          placeData: placesData[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Card(
                      elevation: 10.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Image.network(
                            placesData[index].placesImageURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.0,
                                bottom: 10.0,
                              ),
                              child: Text(
                                placesData[index].placeName,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, bottom: 10.0),
                              child: Text(" | "),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                              child: Text(
                                placesData[index].destination,
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<PlacesData>> _fetchPlaces() {
    return FetchPlaces.fetchPlaces(pageNumber: pageNumber)
        .then((value) => value.places);
  }

  void _goToSearch(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          tvalue: value,
        ),
      ),
    );
  }
}
