import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/widgets/jsonListViewWidget/jsonListView.dart';
import 'package:flutter_app/widgets/placesWidgets/placeCard.dart';

import 'package:flutter_app/widgets/placesWidgets/nestedTabBar.dart';
import '../services/fetchPlaces.dart';
import '../modals/placesModal/places.dart';

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
  int _pageNumber;
  bool isLoading, canSearch;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _search = TextEditingController();
    _pageNumber = 1;
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
          _pageNumber++;
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

            return JsonListView(
              snapshot: snapshot,
              listData: placesData,
              scrollController: _scrollController,
              onTapWidget: (value) => NestedTabBar(
                placeData: placesData[value],
              ),
              childWidget: (value) => PlaceCard(
                placesData: placesData,
                index: value,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<PlacesData>> _fetchPlaces() {
    return FetchPlaces.fetchPlaces(pageNumber: _pageNumber)
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
