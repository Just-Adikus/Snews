import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_news/provider/theme_provider.dart';
import 'package:rss_news/screens/first_screen.dart';
import 'package:rss_news/screens/second_screen.dart';
import 'package:rss_news/screens/third_screen.dart';
import 'package:rss_news/screens/fourth_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rss_news/widget/theme_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: AnimatedSplashScreen(
            splash: Center(
                child: Container(
              child: Text(
                'SNEWS',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            )),
            duration: 1000,
            nextScreen: MyDrawerApp(),
          ),
        );
      });
}


class MyDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("SNEWS",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text("Политика"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstScreenRSS()));
              },
            ),
            ListTile(
              title: Text("Экономика"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondScreenRSS()));
              },
            ),
            ListTile(
              title: Text("Общество"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThirdScreenRSS()));
              },
            ),
            ListTile(
              title: Text("События"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FourthScreenRSS()));
              },
            ),
            ListTile(
              title: Text("Версия"),
              trailing: FutureBuilder(
                future: getVersionNumber(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) =>
                        Text(
                  snapshot.hasData ? snapshot.data ?? '' : "Loading ...",
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                ? Colors.grey.shade900
                : Colors.blue,
        title: Text("SNEWS Новости"),
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Container(
        padding:
            EdgeInsets.only(left: 10.0, top: 100, right: 10.0, bottom: 100.0),
        child: Column(
          children: [
          Image.asset('assets/images/newspaper.png'),
          Spacer(),
          Text( "Добро пожаловать!  SNEWS является пользовательским приложением с открытым исходным кодом ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,),
          ),
        ]),
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }
}
