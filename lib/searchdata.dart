import 'package:http/http.dart' as http;
import 'dart:convert';
import 'searchmodel.dart';

Future fetchdata(String key, String offset) async {
  // List myList = [];

  final response = await http.get(
      'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=$key&gpslimit=10&gpsoffset=$offset');

  if (response.statusCode == 200) {
    var resp = response.body != '' ? json.decode(response.body) : null;

    var list = resp['query'] != null
        ? resp['query']['pages']
        : {
            {"title": "$key End of List"}
          };

    // var data = SearchData.fromJson(list);
    // print(resp.runtimeType);
    // print(list.runtimetype);
    var ldata =
        list.map<SearchData>((jdata) => SearchData.fromJson(jdata)).toList();
    // myList.addAll(ldata);
    // print(myList.runtimeType);
    // print(myList.length);
    // myList.forEach((post) => print('Post id: ${post.title}'));
    // print(ldata.length);
    return ldata;
  } else {
    throw Exception('Failed to load data');
  }
}
