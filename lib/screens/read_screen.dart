import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/theme_provider.dart';
import '../widget/appbar_icon.dart';
import '../widget/theme_button.dart';

class ReadScreen extends StatefulWidget {
  final urlNews;

  ReadScreen({@required this.urlNews});

  @override
  _ReadScreenState createState() => _ReadScreenState();
}
class _ReadScreenState extends State<ReadScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
     return MaterialApp (
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home:Scaffold(
        appBar: AppBar(
          backgroundColor:
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                  ? Colors.grey.shade900
                  : Colors.blue,
          centerTitle: true,
          title: Text('SNEWS Новости'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            ChangeThemeIconWidget(),
            ChangeThemeButtonWidget(),
          ],
        ),
        body: WebView(
          initialUrl: '${widget.urlNews}',
          javascriptMode: JavascriptMode.unrestricted,
        )
        )
        );
  }
  }
