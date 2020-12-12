import 'dart:ui';
import 'package:flutter/material.dart';
import 'searchfunc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Search",
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    hintText: "Search Wikipedia",
                    filled: true,
                    fillColor: Colors.grey[150],
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                onTap: () {
                  focusNode.unfocus();
                  showSearch(
                      context: context, delegate: SearchAppBarDelegate());
                },
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: items.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text('${items[index]}'),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
