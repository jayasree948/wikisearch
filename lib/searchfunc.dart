import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'searchdata.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchAppBarDelegate extends SearchDelegate<String> {
  String searchFieldLabel = "Search Wikipedia";
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        FocusScope.of(context).unfocus();
        this.close(context, null);
        // this.close(context, this.query);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: 'Voice input',
              onPressed: () {
                this.query = 'TBW: Get input from voice';
              },
            ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return WebView(
      initialUrl: "https://en.wikipedia.org/wiki/${this.query}",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return this.query.isEmpty
        ? Container()
        : WordSuggestions(
            query: this.query,
            onSelected: (String suggestion) {
              this.query = suggestion;
              // this._history.insert(0, suggestion);
              showResults(context);
            },
          );
  }
}

class WordSuggestions extends StatefulWidget {
  final String query;
  final ValueChanged<String> onSelected;

  WordSuggestions({this.query, this.onSelected});

  @override
  _WordSuggestionsState createState() => _WordSuggestionsState();
}

class _WordSuggestionsState extends State<WordSuggestions> {
  int page = 0;
  List myList = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        for (int i = page; i < page + 10; i++) {
          // myList.add("Item : ${i + 1}");
        }

        setState(() {
          page = page + 10;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle1;

    return FutureBuilder(
        future: fetchdata(widget.query, page.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title: RichText(
                      text: TextSpan(
                        text:
                            widget.query.length > snapshot.data[i].title.length
                                ? snapshot.data[i].title
                                : snapshot.data[i].title
                                    .substring(0, widget.query.length),
                        style: textTheme.copyWith(fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.query.length >
                                    snapshot.data[i].title.length
                                ? null
                                : snapshot.data[i].title
                                    .substring(widget.query.length),
                            style: textTheme,
                          ),
                        ],
                      ),
                    ),
                    subtitle: snapshot.data[i].terms == null
                        ? null
                        : Text(snapshot.data[i].terms.description[0]),
                    trailing: snapshot.data[i].thumbnail == null
                        ? null
                        : Image(
                            image:
                                NetworkImage(snapshot.data[i].thumbnail.source),
                            height: 40.0,
                            width: 40.0,
                            fit: BoxFit.cover,
                          ),
                    onTap: () {
                      widget.onSelected(snapshot.data[i].title);
                    },
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
