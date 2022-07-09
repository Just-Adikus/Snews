import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:rss_news/common/fetch_http_news.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rss_news/constants.dart';

class ThirdScreenRSS extends StatefulWidget {
  @override
  _HomeScreenRSSState createState() => _HomeScreenRSSState();
}

class _HomeScreenRSSState extends State {
  bool _darkTheme = false;
  List _NewsList = [];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: !_darkTheme ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('SNEWS Общество'),
        ),
        body: FutureBuilder(
          future: _getHttpNews(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 10.0, right: 10.0, bottom: 20.0),
                    scrollDirection: Axis.vertical,
                    itemCount: _NewsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(children: [
                            Text(
                              '${_NewsList[index].title}',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              '${parseDescription(_NewsList[index].description)}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd – kk:mm').format(
                                    DateTime.parse(
                                        '${_NewsList[index].pubDate}'),
                                  ),
                                ),
                                FloatingActionButton.extended(
                                  heroTag: null,
                                  onPressed: () => openFeed(_NewsList[index].link)
                                  ,
                                  label: Text('Читать'),
                                  icon: Icon(Icons.arrow_forward),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      );
                    }),
              );
            }
          },
        ),
      ),
    );
  }


  _getHttpNews() async {
    var response =
        await fetchHttpNews(Uri.parse(THIRD_URL));
    var chanel = RssFeed.parse(response.body);
    chanel.items!.forEach((element) {
      _NewsList.add(element);
    });
    return _NewsList;
  }


 Future<bool> openFeed(String url) async {
    try {
      await launch(
        url,
        enableJavaScript: true,
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}