import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wiki's Search",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          InkWell(
              child: Text("list1"),
              onTap: () {
                _onclicked("Sachin");
              }),
          InkWell(
              child: Text("list2"),
              onTap: () {
                _onclicked("Dog");
              }),
          InkWell(
              child: Text("list3"),
              onTap: () {
                _onclicked("jaya");
              })
        ],
      ),
    );
  }

  _onclicked(String keyword) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(title: Text("search")),
                body: WebView(
                  initialUrl: "https://en.wikipedia.org/wiki/$keyword",
                  javascriptMode: JavascriptMode.unrestricted,
                ))));
  }
}
