import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_news/screens/read_screen.dart';
import 'package:webfeed/webfeed.dart';
import 'package:rss_news/common/fetch_http_news.dart';
import 'package:intl/intl.dart';

import 'package:rss_news/utils/constants.dart';

import '../provider/theme_provider.dart';
import '../widget/appbar_icon.dart';
import '../widget/theme_button.dart';

class HomeScreenRSS extends StatefulWidget {
  @override
  _HomeScreenRSSState createState() => _HomeScreenRSSState();
}

class _HomeScreenRSSState extends State {
  List _NewsList = [];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                  ? Colors.grey.shade900
                  : Colors.blue,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('SNEWS Политика'),
          actions: [
            ChangeThemeIconWidget(),
            ChangeThemeButtonWidget(),
          ],
        ),
        body: FutureBuilder(
          future: _getHttpNews(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
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
                                  backgroundColor: Colors.blue,
                                  heroTag: null,
                                  onPressed: () =>
                                       Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => ReadScreen(urlNews: '${_NewsList[index].link}',)
                                        )),
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
    var response = await fetchHttpNews(Uri.parse(SECOND_URL));
    var chanel = RssFeed.parse(response.body);
    chanel.items!.forEach((element) {
      _NewsList.add(element);
    });
    return _NewsList;
  }

}