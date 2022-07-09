import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/src/models/page_view_model.dart';
import 'package:rss_news/screens/first_screen.dart';
import 'package:rss_news/screens/second_screen.dart';
import 'package:rss_news/screens/third_screen.dart';
import 'package:rss_news/screens/fourth_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
void main() => runApp(Intro());

class Intro extends StatelessWidget {
  
  final pages = [
    PageViewModel(
      pageColor: Colors.blue,
      body: Text(
          'Добро пожаловать!  SNEWS является пользовательским приложением с открытым исходным кодом'),
      title: Text('SNEWS'),
      textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
       mainImage: Image.asset('assets/images/newspaper.png')
    ),
    PageViewModel(
      pageColor: Colors.green,
      body: Text('Если вы любите читать новости то поздравляем .Теперь Новости стали еще доступнее',textAlign:TextAlign.start),
      textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Colors.black),
      mainImage: Image.asset('assets/images/doomer.png')
    ),
    PageViewModel(
      pageColor: Colors.yellow,
      body: Text('Вперед и с песней'),
      textStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.green),
      mainImage: Image.asset('assets/images/thumbup.png')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Flutter',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          skipText: Text('Пропустить',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white)),
          doneText: Text('Принять',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white)),
          showBackButton: false,
          showNextButton: false,
          showSkipButton: true,
          onTapDoneButton: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyListView(),
              )),
          onTapSkipButton: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyListView(),
              )),
        ),
      ),
    );
  }
}



class MyListView extends StatelessWidget {
final List<Widget> aboutBoxChildren = <Widget>[
      const SizedBox(height: 24),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "SNEWS является пользовательским приложением с открытым исходным кодом "),
            TextSpan(
                text: 'https://github.com/Ave-Adikus/flutter_application_1'),
            TextSpan(text: '.'),
          ],
        ),
      ),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SNEWS Категории'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Политика'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstScreenRSS(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Экономика'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreenRSS(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Общество'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreenRSS(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('События'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FourthScreenRSS(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Версия"),
            trailing: FutureBuilder(
              future: getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                snapshot.hasData ? snapshot.data ??'' : "Loading ...",
              ),
            ),
          ),
        ],
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
